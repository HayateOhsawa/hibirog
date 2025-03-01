// chat.js

// ActionCableをインポート
import { createConsumer } from "@rails/actioncable";

// ActionCableのコンシューマーを作成
const consumer = createConsumer();

// ActionCableチャンネルを購読
consumer.subscriptions.create("ChatChannel", {
  connected() {
    // 接続時の処理
    console.log("Connected to the chat channel");
  },

  disconnected() {
    // 切断時の処理
    console.log("Disconnected from the chat channel");
  },

  received(data) {
    // サーバーからデータを受け取ったときの処理
    console.log("Received data:", data);

    // 受け取ったチャットメッセージをHTMLに挿入
    const chatList = document.querySelector(".chats-container");
    const html = buildHTML(data);
    chatList.insertAdjacentHTML("afterbegin", html);
  }
});

// HTML生成関数
const buildHTML = (data) => {
  const chat = data.chat;

  // クライアント側で保持しているログイン中のユーザーIDを取得
  const currentUserId = document.querySelector('meta[name="current_user_id"]').getAttribute('content');
  
  // サーバーから送信されたメッセージのユーザーID
  const chatUserId = chat.user.id;

  const createdAt = new Date(chat.created_at).toLocaleString("ja-JP", {
    timeZone: "Asia/Tokyo",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
  });

  // 自分のメッセージか他人のメッセージかを判定
  const isCurrentUser = chatUserId == currentUserId;

  // HTMLを生成
  const html = `
    <div class="chat ${isCurrentUser ? 'current-user' : 'other-user'}">
      <div class="user-info">
        ${!isCurrentUser ? `<span class="chat-user-name">${data.chat.user.name}</span> さんが投稿しました` : ''}
      </div>
      <div class="chat-message">
        <div class="message-content">
          ${chat.message_content}
        </div>
      </div>
      <div class="chat-date">
        ${isCurrentUser ? `<a href="/chats/${chat.id}" data-turbo-method="delete" class="delete-link">削除</a>` : ''}
        投稿日時： ${createdAt}
      </div>
    </div>
  `;
  return html;
}

// フォーム送信時の非同期通信
function postChat() {

  const form = document.querySelector(".chat-form"); // フォームの要素を取得
  form.addEventListener("submit", (e) => {
    e.preventDefault(); // フォームのデフォルト送信動作をキャンセル
    const formData = new FormData(form); // フォームのデータを収集

    
    // user_id をフォームデータに追加（ここでは仮に `current_user_id` を使う）
    const userId = document.querySelector('meta[name="current_user_id"]').getAttribute('content');
    formData.append('chat[user_id]', userId);
    const XHR = new XMLHttpRequest(); // 新しい非同期リクエストの作成
    XHR.open("POST", "/chats", true); // POSTリクエストを開く
    XHR.responseType = "json"; // サーバーからJSON形式のレスポンスを期待
    XHR.send(formData); // フォームデータを送信

    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`); // エラーメッセージを表示
        return null;
      }

      const chatList = document.querySelector(".chats-container"); // チャット一覧を取得
      const formText = document.querySelector(".message-input");
      if (formText) {
        formText.value = "";
      } else {
        console.error("フォームテキストが見つかりませんでした。");
      }
      chatList.insertAdjacentHTML("afterbegin", buildHTML(XHR.response)); // 修正箇所
      document.querySelector(".message-input").value = ""; // フォームをクリア
    };
  });
}

window.addEventListener('turbo:load', postChat); // Turboドライブのロード時に関数を実行
