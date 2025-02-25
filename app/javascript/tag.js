// app/javascript/index.js
function openTagModal() {
  document.getElementById("tagModal").style.display = "block";
}

function closeTagModal() {
  document.getElementById("tagModal").style.display = "none";
}

function addTag(event, recordId) {
  event.preventDefault();
  const tagName = document.getElementById('tag_name').value;

  if (tagName === '') {
    alert('タグ名を入力してください。');
    return;
  }

  fetch(`/records/${recordId}/add_tag`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
    },
    body: JSON.stringify({ tag_name: tagName })
  })
  .then(response => response.json())
  .then(data => {
    if (data.success) {
      const tagContainer = document.querySelector('.tags');
      const newTag = document.createElement('span');
      newTag.className = 'tag-label';
      newTag.innerText = data.tag_name;
      tagContainer.appendChild(newTag);

      document.getElementById('tag_name').value = '';
      closeTagModal();
    } else {
      alert('タグの追加に失敗しました。');
    }
  })
  .catch(error => {
    console.error('エラー:', error);
  });
}

window.openTagModal = openTagModal;
window.closeTagModal = closeTagModal;
window.addTag = addTag;
