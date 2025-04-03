part of 'styles.dart';

class RobotoFonts {
  static TextStyle getAppFont({
    FontWeight? fontWeight,
    double? fontSize,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      ),
    );
  }
}

class PrimaryTextStyle {
  static final primaryStyle = RobotoFonts.getAppFont(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.whiteColor,
  );
  static final primaryStyle1 = RobotoFonts.getAppFont(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.twitterBlue,
  );

  static final primaryStyle2 = RobotoFonts.getAppFont(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.darkGray,
  );

  static final primaryStyle3 = RobotoFonts.getAppFont(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.mediumGray,
  );
  static final primaryStyle4 = RobotoFonts.getAppFont(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.blackColor,
  );
  static final primaryStyle5 = RobotoFonts.getAppFont(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static final primaryStyle6 = RobotoFonts.getAppFont(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
  );
  static final primaryStyle7 = RobotoFonts.getAppFont(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.mediumGray,
  );
  static final primaryStyle8 = RobotoFonts.getAppFont(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.mediumGray,
  );
  static final primaryStyle9 = RobotoFonts.getAppFont(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.mediumGray,
  );
}
