// lib/presentation/pages/widgets/chat_message_ui.dart
import 'package:flutter/material.dart';

class ChatMessageUI extends StatelessWidget {
  final String messageContent;
  final String timestamp;
  final bool showTimestamp;
  final bool isUserMessage;

  const ChatMessageUI({
    super.key,
    required this.messageContent,
    required this.timestamp,
    required this.showTimestamp,
    required this.isUserMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Align(
        alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (showTimestamp)
              Center(
                child: Text(
                  timestamp,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
            if (showTimestamp) const SizedBox(height: 4),
            if (!showTimestamp) const SizedBox(height: 4),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width *
                    0.75, // Giới hạn 75% chiều rộng màn hình
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color:
                    isUserMessage ? Colors.green[300] : Colors.lightBlue[200],
                borderRadius: isUserMessage
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
              ),
              child: Text(
                messageContent,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
