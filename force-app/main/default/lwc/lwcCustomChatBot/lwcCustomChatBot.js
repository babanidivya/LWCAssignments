import { LightningElement,track } from 'lwc';

/*eslint no-console: "error"*/
let chatTokens = new Map();
chatTokens.set("hello","hi! Please tell,What do you want");
chatTokens.set("want","ok, I will back to you");

export default class LwcCustomChatBot extends LightningElement {
    @track searchKey = ''; 
    
    handleshowchatwindowbody(){
        let chatWindowHideBody = this.template.querySelectorAll('.hideChat');
        let chatWindowShowBody = this.template.querySelectorAll('.showChat');
        if(chatWindowHideBody.length > 0){
            let chatHideBodys = [...chatWindowHideBody];
            chatHideBodys.forEach( chatBody => {
                chatBody.classList.remove('hideChat');
                chatBody.classList.add('showChat');
            });
        }else if(chatWindowShowBody.length > 0){
            let chatShowBodys = [...chatWindowShowBody];
            chatShowBodys.forEach( chatBody => {
                chatBody.classList.remove('showChat');
                chatBody.classList.add('hideChat');
            });    
        }
    }

    handlereply(event){
        console.log(this.searchKey);
        console.log(event);
        console.log(event.KeyCode);
        if(event.keyCode === 13){
            console.log(this.searchKey);
            let chatBody = this.template.querySelectorAll('.chatBody');
            if(chatBody.length > 0){
                this.searchKey = event.target.value;
                let chatBodys = [...chatBody];
                let newChat = `<p  class="user" c-lwccustomchatbot_lwccustomchatbot>${this.searchKey}</p>`;
                let result = "Sorry, I can't get it!";
                
                chatBodys.forEach( chatBdy => {
                    console.log('yes1');
                    console.log(this.searchKey.toLowerCase());
                    console.log(chatTokens.get(this.searchKey.toLowerCase()));
                    if (chatTokens.get(this.searchKey.toLowerCase()) !== undefined) { // Filtering the data in the loop
                        console.log('exist');
                        result = chatTokens.get(this.searchKey.toLowerCase());
                    }
                    let replyChat = `<p  class="reply" c-lwccustomchatbot_lwccustomchatbot>${result}</p>`;
                    console.log(replyChat);
                    chatBdy.innerHTML += newChat + replyChat;
                    this.searchKey = '';
                    //chatBdy.scrollTop = chatBdy.scrollHeight;
                });
            }
        }
        //if (window.event.keyCode === 13) {
    }
}