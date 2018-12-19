class HttpContans {
  static final String baseUrl = "https://nebulaedu.com/";

  ///登录接口
  static final String login = "api/v1/user/login";

  ///获取用户资料
  static final String profile = "api/v1/user/profile";

  ///修改用户头像
  static final String uploadPortrait = "api/v1/user/uploadPortrait/";

  ///话题咨询
  static final String news = "api/v1/news";

  ///话题咨询
  static final String newsDetail = "api/v1/news/";

  ///检查更新
  static final String checkVersion =
      "https://www.pgyer.com/apiv2/app/check?_api_key=c8dcb5514d05960c9369e849e787371e&appKey=";
//  + "&buildVersion=" + AppUtils.getAppVersionName(context)
//  + "&buildBuildVersion=" + AppUtils.getAppVersionCode(context));
}
