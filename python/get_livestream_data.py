from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
import csv


CHANNEL_TAGS=[('@CNNbrasil','UCvdwhh_fDyWccR42-rReZLw'),
    ('@JornalismoVTVSBT','UC40TUSUx490U5uR1lZt3Ajg'),
    ('@InstitutoConhecimentoLiberta','UCaIqJHHo9TJiLINzOFJRl2Q'),
    ('@recordnews','UCuiLR4p6wQ3xLEm15pEn1Xw'),
    ('@jovempannews','UCP391YRAjSOdM_bwievgaZA'),
    ('@brasil247','UCRuy5PigeeBuecKnwqhM4yg'),
    ('@RadioBandNewsFM','UCWijW6tW0iI5ghsAbWDFtTg'),
    ('@DCMTVlive','UCutrj9cR0cNi2PfiTMGAWrA'),
    ('@redetvt','UCmQTY7b5w61WlmBbJ5a8XrQ'),
    ('@forumrevista','UC3sMBA3BdnsKSVI0WB9yVWQ'),
    ('@cbnrede','UCbiGwU0-W1XCDUrt3BTVrag'),
    ('@oFlowNews','UCYpE7GffL46a9WT5b-Rekpg')]

API_KEY='INSERT-YOUR-GCP-API_KEY'
youtube = build('youtube', 'v3', developerKey=API_KEY)


def escrever_csv(data):
    # Specify the output file path
    output_file = 'output.csv'

    # Write array to a CSV file
    with open(output_file, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['canal','audiencia'])
        for row in data:
            writer.writerow(row)

def get_channel_id(CHANNEL_IDENTIFIER):
    print("Pegando ID do canal:",CHANNEL_IDENTIFIER)
    try:
        # Retrieve the channel ID
        response = youtube.search().list(
            part='snippet',
            type="channel",
            q=CHANNEL_IDENTIFIER
        ).execute()

        # Check if the response contains any items
        if 'items' in response and len(response['items']) > 0:
            # Extract the channel ID
            channel_found = response['items'][0]['id']
            print('Channel ID:', channel_found['channelId'])
            return channel_found['channelId']
        else:
            print('Channel not found.')
    except HttpError as e:
        print('An HTTP error occurred:')
        print(e.content)

def get_livestream_id(CHANNEL_ID):
    print("Checando ID para live_stream do canal",CHANNEL_ID)
    try:
        # Retrieve live streams for the channel
        response = youtube.search().list(
            part='id',
            channelId=CHANNEL_ID,
            eventType='live',
            type='video'
        ).execute()

        # Extract the live stream IDs
        live_stream_ids = [item['id']['videoId'] for item in response['items']]

        # Print the live stream IDs
        #print('Live Stream IDs:', live_stream_ids)
        return  live_stream_ids
    except HttpError as e:
        print('An HTTP error occurred:')
        print(e.content)

def get_livestream_views(LIVESTREAM_ID):
    try:
        # Retrieve live stream details
        response = youtube.videos().list(
            part='liveStreamingDetails',
            id=LIVESTREAM_ID
        ).execute()

        # Extract the live stream view count
        stream = response['items'][0]
        view_count = stream['liveStreamingDetails']['concurrentViewers']

        # Print the live stream view count
        print('Live Stream View Count:', view_count)
        return view_count
    except HttpError as e:
        print('An HTTP error occurred:')
        print(e.content)


channel_views_array = []

for channel,channel_id in CHANNEL_TAGS:
    livestream_id = get_livestream_id(channel_id)
    if (len(livestream_id)  > 0):
        livestream_views = get_livestream_views(livestream_id)
        channel_views_array.append((channel, livestream_views))
    else:
        channel_views_array.append((channel, 0))

escrever_csv(channel_views_array)