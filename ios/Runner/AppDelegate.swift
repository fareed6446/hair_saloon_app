import Flutter
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Configure notifications for Hair Salon App
    configureNotifications()
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func configureNotifications() {
    // Request notification permissions
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
      if granted {
        print("Notification permission granted")
      } else {
        print("Notification permission denied: \(error?.localizedDescription ?? "Unknown error")")
      }
    }
    
    // Set notification delegate
    UNUserNotificationCenter.current().delegate = self
    
    // Configure notification categories for Hair Salon App
    let bookingReminderCategory = UNNotificationCategory(
      identifier: "BOOKING_REMINDER",
      actions: [
        UNNotificationAction(identifier: "VIEW_BOOKING", title: "View Booking", options: [.foreground]),
        UNNotificationAction(identifier: "CANCEL_BOOKING", title: "Cancel", options: [.destructive])
      ],
      intentIdentifiers: [],
      options: []
    )
    
    let promotionalCategory = UNNotificationCategory(
      identifier: "PROMOTIONAL",
      actions: [
        UNNotificationAction(identifier: "VIEW_OFFER", title: "View Offer", options: [.foreground]),
        UNNotificationAction(identifier: "DISMISS", title: "Dismiss", options: [])
      ],
      intentIdentifiers: [],
      options: []
    )
    
    UNUserNotificationCenter.current().setNotificationCategories([
      bookingReminderCategory,
      promotionalCategory
    ])
  }
  
  // MARK: - UNUserNotificationCenterDelegate
  // Handle notification when app is in foreground
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    // Show notification even when app is in foreground
    completionHandler([.alert, .badge, .sound])
  }
  
  // Handle notification tap
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    let userInfo = response.notification.request.content.userInfo
    
    // Handle different notification actions
    switch response.actionIdentifier {
    case "VIEW_BOOKING":
      // Navigate to booking details
      if let bookingId = userInfo["booking_id"] as? String {
        // This would be handled by Flutter side
        print("Navigate to booking: \(bookingId)")
      }
    case "VIEW_OFFER":
      // Navigate to promotional offer
      print("Navigate to promotional offer")
    case "CANCEL_BOOKING":
      // Handle booking cancellation
      if let bookingId = userInfo["booking_id"] as? String {
        print("Cancel booking: \(bookingId)")
      }
    default:
      // Default tap action
      print("Notification tapped")
    }
    
    completionHandler()
  }
}
