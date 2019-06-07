![header](./ed-badge.png)

# notifications
A quick Swift 5 example project that shows an observer and a post with data in action. Loading an online image of Charlotte de Witte, and the notification posts with the image data when it receives it. An observer in VC calls the method in VC which sets the loaded image that's been passed as data.

This doesn't show multiple observers, but that would be why you'd use Notifications instead of a protocol delegate. Many class objects could observe, and with a single post with data from somewhere, they would all get the message with the data. 

![Charlotte](./charlotte.jpg)
