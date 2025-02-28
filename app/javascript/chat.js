// 非同期通信でHTMLを生成する関数
const buildHTML = (XHR) => {
  const chat = XHR.response.chat; // サーバーからのレスポンスを取得
  const createdAt = new Date(chat.created_at).toLocaleString("ja-JP", {
    timeZone: "Asia/Tokyo", // 日本時間に合わせる
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
  });

  const html = `
    <div class="chat ${chat.user_id == XHR.response.current_user_id ? 'current-user' : 'other-user'}">
      <div class="user-info">
        ${chat.user_id !== XHR.response.current_user_id ? `<span class="chat-user-name">${chat.user_name}</span> さんが投稿しました` : ''}
      </div>
      <div class="chat-message">
        <div class="message-content">
          ${chat.message_content}
        </div>
        ${chat.user_id == XHR.response.current_user_id ? `<div class="delete-button">
          <a href="/chats/${chat.id}" data-turbo-method="delete" class="destroy-link">
            削除
          </a>
        </div>` : ''}
      </div>
      <div class="chat-date">
        投稿日時： ${createdAt}
      </div>
    </div>
  `;
  return html;
};


// フォーム送信時の非同期通信
function postChat (){
  const form = document.querySelector(".chat-form"); // フォームの要素を取得
  form.addEventListener("submit", (e) => {
    e.preventDefault(); // フォームのデフォルト送信動作をキャンセル
    const formData = new FormData(form); // フォームのデータを収集
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
      const formText = document.querySelector(".message-input"); // フォームのテキスト入力エリアを取得
      chatList.insertAdjacentHTML("afterbegin", buildHTML(XHR)); // 新しいチャットを非同期で一覧に挿入
      document.querySelector(".message-input").value = ""; // フォームをクリア
    };
  });
}

window.addEventListener('turbo:load', postChat); // Turboドライブのロード時に関数を実行
