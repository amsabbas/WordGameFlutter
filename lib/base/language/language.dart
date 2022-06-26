import 'package:get/get.dart';

class MessageKeys {
  static const String startGameButtonTitle = 'startGameButtonTitle';
  static const String settingsButtonTitle = 'settingsButtonTitle';
  static const String helpButtonTitle = 'helpButtonTitle';
  static const String helpTitle = 'helpTitle';
  static const String helpValueAddedMessage = 'helpValueAddedMessage';
  static const String moreAppsButtonTitle = 'moreAppsButtonTitle';
  static const String settingsSoundTitle = 'settingsSoundTitle';
  static const String settingsShareTitle = 'settingsShareTitle';
  static const String settingsResetTitle = 'settingsResetTitle';
  static const String settingsConfirmationResetMessage = 'settingsConfirmationResetMessage';
  static const String settingsResetSuccessMessage =
      'settingsResetSuccessMessage';
  static const String dismiss = 'dismiss';
  static const String okay = 'okay';
  static const String yes = 'yes';
  static const String no = 'no';
  static const String next = 'next';
  static const String error = "error";
  static const String attention = "attention";
  static const String downloadNowTitleKey = 'downloadNowTitleKey';

  static const String firstGroupTitleKey = 'firstGroupTitleKey';
  static const String secondGroupTitleKey = 'secondGroupTitleKey';
  static const String thirdGroupTitleKey = 'thirdGroupTitleKey';
  static const String forthGroupTitleKey = 'forthGroupTitleKey';
  static const String fifthGroupTitleKey = 'fifthGroupTitleKey';
  static const String sixthGroupTitleKey = 'sixthGroupTitleKey';
  static const String seventhGroupTitleKey = 'seventhGroupTitleKey';
  static const String eighthGroupTitleKey = 'eighthGroupTitleKey';
  static const String ninthGroupTitleKey = 'ninthGroupTitleKey';
  static const String tenthGroupTitleKey = 'tenthGroupTitleKey';
  static const String selectGroupTitleKey = 'selectGroupTitleKey';
  static const String levelTitleKey = 'levelTitleKey';
  static const String groupLockedTitleKey = 'groupLockedTitleKey';
  static const String levelLockedTitleKey = 'levelLockedTitleKey';
  static const String groupLockedDescKey = 'groupLockedDescKey';
  static const String levelLockedDescKey = 'levelLockedDescKey';
  static const String failHelpMessageKey = 'failHelpMessageKey';
  static const String gameHelpConfirmationMessage = 'gameHelpConfirmationMessage';
  static const String gameHelpEmptyMessage = 'gameHelpEmptyMessage';
  static const String gameLevelCompletedMessage = 'gameLevelCompletedMessage';

}

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {},
        'ar': {
          MessageKeys.next: 'التالي',
          MessageKeys.yes: 'نعم',
          MessageKeys.no: 'لا',
          MessageKeys.okay: 'حسناً',
          MessageKeys.attention: 'تنبيه',
          MessageKeys.startGameButtonTitle: 'ابدأ',
          MessageKeys.settingsButtonTitle: 'الإعدادات ',
          MessageKeys.helpButtonTitle: 'اضافة مساعدة',
          MessageKeys.moreAppsButtonTitle: 'تطبيقاتنا',
          MessageKeys.helpValueAddedMessage: 'تم اضافة المساعدة بنجاح',
          MessageKeys.helpTitle: 'مساعدة',
          MessageKeys.settingsSoundTitle: 'الصوت',
          MessageKeys.settingsShareTitle: 'شارك اللعبة',
          MessageKeys.settingsConfirmationResetMessage : 'هل انت متأكد من ازالة جميع المراحل المسجلة لديك ؟',
          MessageKeys.settingsResetTitle: 'اعادة ضبط اللعبة',
          MessageKeys.downloadNowTitleKey: 'تحميل الان',
          MessageKeys.settingsResetSuccessMessage: 'تم اعادة ضبط اللعبة بنجاح',
          MessageKeys.dismiss: "إخفاء",
          MessageKeys.firstGroupTitleKey: "المجموعة الاولي",
          MessageKeys.secondGroupTitleKey: "المجموعة الثانية",
          MessageKeys.thirdGroupTitleKey: "المجموعة الثالثة",
          MessageKeys.forthGroupTitleKey: "المجموعة الرابعة",
          MessageKeys.fifthGroupTitleKey: "المجموعة الخامسة",
          MessageKeys.sixthGroupTitleKey: "المجموعة السادسة",
          MessageKeys.seventhGroupTitleKey: "المجموعة السابعة",
          MessageKeys.eighthGroupTitleKey: "المجموعة الثامنة",
          MessageKeys.ninthGroupTitleKey: "المجموعة التاسعة",
          MessageKeys.tenthGroupTitleKey: "المجموعة العاشرة",
          MessageKeys.selectGroupTitleKey: "اختر مجموعة",
          MessageKeys.levelTitleKey: "مرحلة",
          MessageKeys.groupLockedTitleKey: "المجموعة مغلقة",
          MessageKeys.levelLockedTitleKey: "المرحلة مغلقة",
          MessageKeys.groupLockedDescKey:
              " المجموعة مغلقة يجب عليك حل الالغاز بالترتيب في المجموعات السابقة اولا",
          MessageKeys.levelLockedDescKey:
              "المرحلة مغلقة يجب عليك حل الالغاز بالترتيب",
          MessageKeys.error: "خطأ",
          MessageKeys.failHelpMessageKey: "عذرا حدث خطأ في اضافة المساعدة. الرجاء المحاولة في وقت اخر",
          MessageKeys.gameHelpConfirmationMessage: 'هل انت متأكد من استخدام المساعدة ؟',
          MessageKeys.gameHelpEmptyMessage: 'عذرا لا يوجد لديك مساعدة للاستخدام',
          MessageKeys.gameLevelCompletedMessage: '  مبروك .. وجدت جميع الكلمات'
        }
      };
}
