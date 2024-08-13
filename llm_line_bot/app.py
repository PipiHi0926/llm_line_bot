# main.py

import os
from flask import Flask, request, abort
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address
from linebot import LineBotApi, WebhookHandler
from linebot.exceptions import InvalidSignatureError
from linebot.models import MessageEvent, TextMessage, TextSendMessage
from langchain_groq import ChatGroq

app = Flask(__name__)

# Initialize Limiter
limiter = Limiter(
    get_remote_address,
    app=app,
    default_limits=["200 per day", "50 per hour"],
    storage_uri="memory://",
)

# LINE Bot configuration
line_bot_api = LineBotApi(os.getenv("LINE_CHANNEL_ACCESS_TOKEN"))
handler = WebhookHandler(os.getenv("LINE_CHANNEL_SECRET"))

# Groq LLM configuration
api_key = os.getenv("GROQ_API_KEY")
llm = ChatGroq(
    model="llama-3.1-70b-versatile",
    temperature=0.1,
    max_tokens=None,
    timeout=None,
    max_retries=3,
    api_key=api_key,
)


@app.route("/callback", methods=["POST"])
@limiter.limit("100 per day")  # Limit to 100 calls per day
def callback():
    signature = request.headers["X-Line-Signature"]
    body = request.get_data(as_text=True)
    try:
        handler.handle(body, signature)
    except InvalidSignatureError:
        abort(400)
    return "OK"


@handler.add(MessageEvent, message=TextMessage)
def handle_message(event):
    user_id = event.source.user_id

    # Check if user has exceeded the limit
    if limiter.check() is False:
        line_bot_api.reply_message(
            event.reply_token,
            TextSendMessage(text="很抱歉，您今天的使用次數已達上限。請明天再試。"),
        )
        return

    user_message = event.message.text

    messages = [
        (
            "system",
            "你是可愛的回答問題專家，喜歡回答時夾雜表情符號，並喜歡語助詞加上喵",
        ),
        ("human", user_message),
    ]

    ai_response = llm.invoke(messages)

    line_bot_api.reply_message(
        event.reply_token, TextSendMessage(text=ai_response.content)
    )


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
