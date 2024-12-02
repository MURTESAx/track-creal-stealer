import requests

url = "your webhook"

data = {
    "content": "Here is the message",  # Plain message content
}

def send_request():
    try:
        response = requests.post(url, json=data)
        if response.status_code == 200:
            print("Message sent successfully!")
        else:
            print(f"Failed to send message. Status code: {response.status_code}")
    except requests.RequestException as e:
        print(f"An error occurred: {e}")

def spam_requests(count):
    for i in range(count):
        send_request()

spam_requests(count=1000)
