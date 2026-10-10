<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Assistant - ABIMART</title>
    <link rel="stylesheet" href="css/premium.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .chat-container {
            max-width: 800px;
            margin: 2rem auto;
            background: var(--bg-main);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--border-color);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            height: 70vh;
        }
        .chat-header {
            padding: 1.5rem 2rem;
            background: var(--bg-secondary);
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .chat-title {
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 1.25rem;
            font-weight: 700;
        }
        .chat-title i { color: var(--accent); font-size: 1.5rem; }
        
        .chat-box {
            flex: 1;
            padding: 2rem;
            overflow-y: auto;
            background: var(--bg-main);
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        .message {
            max-width: 80%;
            padding: 1rem 1.5rem;
            border-radius: var(--radius-lg);
            line-height: 1.5;
            animation: slideUp 0.3s ease forwards;
        }
        .msg-bot {
            background: var(--bg-secondary);
            color: var(--text-primary);
            align-self: flex-start;
            border-bottom-left-radius: 4px;
        }
        .msg-user {
            background: var(--accent);
            color: white;
            align-self: flex-end;
            border-bottom-right-radius: 4px;
        }
        
        .chat-input-area {
            padding: 1.5rem 2rem;
            background: var(--bg-secondary);
            border-top: 1px solid var(--border-color);
            display: flex;
            gap: 1rem;
        }
        .chat-input-wrapper {
            flex: 1;
            position: relative;
        }
        .chat-input {
            width: 100%;
            padding: 1rem 1.5rem;
            border: 1px solid var(--border-color);
            border-radius: var(--radius-full);
            background: var(--bg-main);
            color: var(--text-primary);
            font-size: 1rem;
            outline: none;
            transition: all var(--transition-fast);
        }
        .chat-input:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(67, 56, 202, 0.1);
        }
        .send-btn {
            background: var(--accent);
            color: white;
            border: none;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all var(--transition-fast);
        }
        .send-btn:hover {
            background: var(--accent-hover);
            transform: scale(1.05);
        }
    </style>
    <script>
        async function sendMessage() {
            const inputField = document.getElementById('chat-input');
            const chatBox = document.getElementById('chat-box');
            const input = inputField.value.trim();
            
            if (!input) return;
            
            // Add user message
            chatBox.innerHTML += `
                <div class="message msg-user">
                    ${input}
                </div>`;
            inputField.value = '';
            chatBox.scrollTop = chatBox.scrollHeight;
            
            try {
                const response = await fetch('api/chatbot', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ message: input })
                });
                
                const data = await response.json();
                
                // Add bot message
                chatBox.innerHTML += `
                    <div class="message msg-bot">
                        ${data.reply}
                    </div>`;
                chatBox.scrollTop = chatBox.scrollHeight;
            } catch (e) {
                // Mock fallback if backend API is not yet running
                setTimeout(() => {
                    chatBox.innerHTML += `
                        <div class="message msg-bot">
                            I'm here to help you find the best products on ABIMART! Could you tell me what you're looking for today?
                        </div>`;
                    chatBox.scrollTop = chatBox.scrollHeight;
                }, 600);
            }
        }
        
        function checkEnter(event) {
            if (event.key === 'Enter') sendMessage();
        }
    </script>
</head>
<body style="background: var(--bg-tertiary); min-height: 100vh; display: flex; flex-direction: column;">
    
    <!-- Navigation -->
    <nav class="navbar" style="position: static;">
        <a href="index.jsp" class="nav-brand">
            <i class="fa-solid fa-cube" style="color: var(--accent);"></i>
            ABIMART
        </a>
        <div class="nav-links">
            <a href="index.jsp"><i class="fa-solid fa-arrow-left"></i> Back to Store</a>
        </div>
    </nav>

    <!-- Chat Container -->
    <div class="container" style="flex: 1; display: flex; flex-direction: column; justify-content: center; width: 100%; padding: 0 5%;">
        <div class="chat-container">
            <div class="chat-header">
                <div class="chat-title">
                    <i class="fa-solid fa-robot"></i>
                    <div>
                        <div>ABIMART AI</div>
                        <div class="text-sm text-muted" style="font-weight: 400;">Your personal shopping assistant</div>
                    </div>
                </div>
            </div>
            
            <div class="chat-box" id="chat-box">
                <div class="message msg-bot">
                    Hi! I'm your ABIMART AI shopping assistant. How can I help you discover amazing products today?
                </div>
            </div>
            
            <div class="chat-input-area">
                <div class="chat-input-wrapper">
                    <input type="text" id="chat-input" class="chat-input" placeholder="Type your message here..." onkeypress="checkEnter(event)">
                </div>
                <button class="send-btn" onclick="sendMessage()">
                    <i class="fa-solid fa-paper-plane"></i>
                </button>
            </div>
        </div>
    </div>
</body>
</html>
