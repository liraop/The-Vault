# -*- coding: utf-8 -*-

# Sample Python code for youtube.channels.list
# See instructions for running these code samples locally:
# https://developers.google.com/explorer-help/code-samples#python

import os
import json

import google_auth_oauthlib.flow
import googleapiclient.discovery
import googleapiclient.errors

scopes = ["https://www.googleapis.com/auth/youtube.readonly"]

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
                'transcription' : ''
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
                'transcription' : ''
                })

        nextPageToken = response.get('nextPageToken', None)

    print("done")
    print("Found %d videos" % len(videos))

if __name__ == "__main__":
    main()