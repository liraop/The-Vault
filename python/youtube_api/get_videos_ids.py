# -*- coding: utf-8 -*-

# Sample Python code for youtube.channels.list
# See instructions for running these code samples locally:
# https://developers.google.com/explorer-help/code-samples#python

import os
import json
from datetime import datetime

import google_auth_oauthlib.flow
import googleapiclient.discovery
import googleapiclient.errors
from youtube_transcript_api import YouTubeTranscriptApi

scopes = ["https://www.googleapis.com/auth/youtube.readonly"]

def create_timestamp():
    """
    Create a timestamp string in the format 'YYYY-MM-DD_HH-MM-SS'.
    """
    return datetime.now().strftime("%Y-%m-%d_%H-%M-%S")

def serialize_list_to_file(elements, file_name=""):
    if file_name == "":
        file_name = "%s_videos" % create_timestamp()
    try:
        with open(file_name, 'w') as file:
            json.dump(elements, file, indent=4)
        print(f"List serialized to '{file_name}' successfully.")
    except Exception as e:
        print(f"Error serializing list to '{file_name}': {e}")

def extract_and_format_text(entries):
    """
    Extract 'text' field from entries and format into a concatenated UTF-8 English text variable.

    Args:
        entries (list): List of dictionaries containing 'text' field.

    Returns:
        str: Concatenated UTF-8 English text variable.
    """
    concatenated_text = ""
    for entry in entries:
        text = entry.get("text", "")
        concatenated_text += text + " "

    # Encode to UTF-8
    concatenated_text = concatenated_text.encode("utf-8").decode("utf-8")

    return concatenated_text.strip()

def main():
    # Disable OAuthlib's HTTPS verification when running locally.
    # *DO NOT* leave this option enabled in production.
    os.environ["OAUTHLIB_INSECURE_TRANSPORT"] = "1"

    api_service_name = "youtube"
    api_version = "v3"
    client_secrets_file = "oauth_secret.json"

    # Get credentials and create an API client
    flow = google_auth_oauthlib.flow.InstalledAppFlow.from_client_secrets_file(
        client_secrets_file, scopes)

    credentials = flow.run_local_server(port=0)
    youtube = googleapiclient.discovery.build(
        api_service_name, api_version, credentials=credentials)

    request = youtube.channels().list(
        part="snippet,contentDetails",
        mine=True
    )

    print("Requesting channel lists")
    response = request.execute()
    uploads_id=response['items'][0]['contentDetails']['relatedPlaylists']['uploads']

    videos = []

    request = youtube.playlistItems().list(
        part="snippet,contentDetails",
        maxResults=50,
        playlistId=uploads_id
    )
    print("Requesting initial playlistItems...")
    response = request.execute()
    nextPageToken = response.get('nextPageToken', None)
    for playlistItem in response['items']:
            videos.append({
                'title' : playlistItem['snippet']['title'],
                'id': playlistItem['contentDetails']['videoId'],
                'transcript' : []
            })

    while nextPageToken != None:
        print("Requesting next page...")
        response = youtube.playlistItems().list(
            part="snippet,contentDetails",
            maxResults=50,
            playlistId=uploads_id,
            pageToken=nextPageToken
        ).execute()

        for playlistItem in response['items']:
            videos.append({
                'title' : playlistItem['snippet']['title'],
                'id': playlistItem['contentDetails']['videoId'],
                'transcript' : []
                })

        nextPageToken = response.get('nextPageToken', None)

    print("DONE...")
    print("Found %d videos" % len(videos))

    for v in range(len(videos)):
        print("[%s] Pegando transcrição" % videos[v]['title'])
        try:
            videos[v]['transcript'] = YouTubeTranscriptApi.get_transcript(videos[v]['id'], languages=['pt'])
            print(videos[v]['transcript'])
        except:
            print("Não foi possível pegar a transcrição.")
        print("[%s] Finalizado" % videos[v]['title'])

    serialize_list_to_file(videos)

    for v in range(len(videos)):
        video = videos[v]
        if len(video['transcript']) > 0:
            formatted_video_transcript = extract_and_format_text(video['transcript'])
            print (formatted_video_transcript)


if __name__ == "__main__":
    main()