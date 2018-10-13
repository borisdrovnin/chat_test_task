import socket from "./socket"

window.addEventListener('load', function() {
  let chatInput = document.querySelector("#chat-input")

  if(chatInput){
    let chatId            = document.querySelector("#chat-id")
    let channelName       = `chat:${chatId.value}`
    let channel           = socket.channel(channelName, {})
    let username          = document.querySelector("#username")
    let messagesContainer = document.querySelector("#messages")

    chatInput.addEventListener("keypress", event => {
      if(event.keyCode === 13 && chatInput.value){
        channel.push("new_msg", {content: chatInput.value, username: username.value})
        chatInput.value = ""
      }
    })

    channel.on("new_msg", payload => {
      let messageItem = document.createElement("li")
      messageItem.innerHTML = `
        <div><strong>${payload.username}</strong>
        </div><div>${payload.content}</div>`
      messageItem.classList.add("list-group-item");
      messagesContainer.appendChild(messageItem)
      messagesContainer.scrollTop = messagesContainer.scrollHeight
    })

    channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })

    messagesContainer.scrollTop = messagesContainer.scrollHeight
  }
});
