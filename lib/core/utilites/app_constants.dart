import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstants {

  /// onBoarding constants
  static const t1 = 'Welcome to Emtelaak';
  static const t2 = 'Explore High-Quality Deals';
  static const t3 = 'Full Financial Visibility';
  static const t4 = 'Let’s Build Your Portfolio';
  static const d1 = 'Your gateway to smarter real estate investing.';
  static const d2 = 'Access handpicked property offerings with full transparency.';
  static const d3 = 'Dive into returns, risk, documents, and projections—before you invest.';
  static const d4 = 'Let’s Build Your Portfolio';



  /// Authentication messages
  static const sendEmailSuccessfully = 'Verification email sent successfully';
  static const failToSendEmail = 'Failed to send verification email - Please check your connection and try again';
  static const unauthorizedAccess = 'Unauthorized. Please login again.';
  static const sessionExpired = 'Your session has expired. Please login again.';

  /// KYC Status Messages
  static const kycNotStarted = 'KYC verification not started';
  static const kycInProgress = 'KYC verification in progress';
  static const kycApproved = 'KYC verification approved';
  static const kycRejected = 'KYC verification rejected';
  static const kycAdditionalInfoRequired = 'Additional information required for KYC';
  static const kycPendingReview = 'KYC verification pending review';
  static const kycExpired = 'KYC verification expired - Please renew';

  static const kycSubmissionSuccess = 'KYC documents submitted successfully';
  static const kycSubmissionFailed = 'Failed to submit KYC documents';
  static const kycDocumentUploadSuccess = 'Document uploaded successfully';
  static const kycDocumentUploadFailed = 'Failed to upload document';

  /// KYC Instructions
  static const kycInstructions = 'Please upload clear copies of the required documents';
  static const kycIdInstructions = 'Upload government-issued ID (Passport, Driver License, National ID)';
  static const kycProofOfAddressInstructions = 'Upload recent utility bill or bank statement (not older than 3 months)';
  static const kycSelfieInstructions = 'Take a clear selfie holding your ID next to your face';

  /// Error Messages
  static const networkError = 'Network error occurred. Please check your connection.';
  static const serverError = 'Server error occurred. Please try again later.';
  static const parsingError = 'Failed to process response. Please contact support.';
  static const unexpectedError = 'An unexpected error occurred. Please try again.';
  static const documentDeletedSuccessfully = 'document deleted Successfully';
  static const failToDeleteDocument = 'Fail to delete  Document';

  ///Success Messages
  static const documentUploadedSuccessfully = 'document Uploaded Successfully';
  static const accreditationSubmittedSuccessfully = 'document Submitted Successfully';
}

class SizeApp
{
  static double radius = 24.0.w;
  static double radiusMed = 16.0.w; // for cards
  static double radiusSmall = 8.0.w; // for cards
  static double padding = 8.0.w;
  static double iconSize = 24.0.w;
  static double iconSizeSmall = 16.0.w;
  static double s2 = 2.0.w;
  static double s5 = 5.0.w;
  static double s8 = 8.0.w;
  static double s10 = 10.0.w;
  static double s12 = 12.0.w;
  static double s16 = 16.0.w;
  static double s20 = 20.0.w;
  static double s24 = 24.0.w;
  static double s30 = 30.0.w;
  static double s32 = 32.0.w;
  static double s40 = 40.0.h;
  static double s44 = 44.0.w;
  static double s48 = 48.0.w;
  static double s50 = 50.0.h;
  static double s69 = 69.0.w;
  static double s70 = 70.0.w;
  static double s110 = 110.0.h;
  static double homeIcons = 60.0;
  static double smallIcons = 60.0;
  static double logoSize = 165.0;
  static double imageIconSize = 300.0;

}