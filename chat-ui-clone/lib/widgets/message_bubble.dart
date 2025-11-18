import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/message_model.dart';
import '../theme/app_theme.dart';

/// Message Bubble Widget
/// Displays a single message with proper styling based on sender
class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format timestamp to display time (e.g., "10:30 AM")
    final timeString = DateFormat('h:mm a').format(message.timestamp);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        // Align messages based on sender
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end // User messages on right
            : MainAxisAlignment.start, // Friend messages on left
        children: [
          // Friend avatar (only for friend messages)
          if (!message.isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: AppTheme.primaryColor,
              child: const Icon(
                Icons.smart_toy,
                size: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
          ],

          // Message bubble container
          Flexible(
            child: Column(
              crossAxisAlignment: message.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                // Message bubble
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    // Different colors for user and friend
                    color: message.isUser
                        ? AppTheme.userBubbleColor
                        : AppTheme.friendBubbleColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      // Different corner radius based on sender
                      bottomLeft: message.isUser
                          ? const Radius.circular(20)
                          : const Radius.circular(4),
                      bottomRight: message.isUser
                          ? const Radius.circular(4)
                          : const Radius.circular(20),
                    ),
                    // Soft shadow for depth
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: message.isUser
                        ? AppTheme.messageTextUser
                        : AppTheme.messageTextFriend,
                  ),
                ),
                const SizedBox(height: 4),
                
                // Timestamp
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    timeString,
                    style: AppTheme.timestampText,
                  ),
                ),
              ],
            ),
          ),

          // User avatar (only for user messages)
          if (message.isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
              child: const Icon(
                Icons.person,
                size: 18,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
