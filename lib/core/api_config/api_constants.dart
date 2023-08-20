// const kBaseUrl = 'http://192.168.1.3:3000/v1';
// const domain = 'https://hospital-home.herokuapp.com';
// const domain = 'http://178.128.193.58:4444';
// const domain = 'http://10.0.2.2:4444';
const domain = 'http://146.190.159.212';

String getPhotoLink(String photo) => domain + '/img/' + photo;
// const domain = 'http://192.168.8.100:3000';

// const kBaseUrl = 'https://wyca.herokuapp.com/v1';
const kBaseUrl = '$domain/v1';

const kRegister = '$kBaseUrl/auth/register';
const kRegisterProvider = '$kBaseUrl/auth-pharmacy/register';
const kForgotPassword = '$kBaseUrl/auth/forgot-password';
const kForgotPasswordFirebase = '$kBaseUrl/auth/forgot-password-firebase';

const kChangephone = '$kBaseUrl/auth/change-phone';

const kSendOtp = '$kBaseUrl/auth/send-verification-otp';

const kverifyForgotPassword = '$kBaseUrl/auth/verify-forget-password-otp';
const kverifyChangephone = '$kBaseUrl/auth/verify-change-phone-otp';

const kVerifyOtp = '$kBaseUrl/auth/verify-otp';
const kVerifyOtpFirebase = '$kBaseUrl/auth/verify-otp-firebase';

const kResetPassword = '$kBaseUrl/auth/reset-password';
const kResetPasswordFirebase = '$kBaseUrl/auth/reset-password-firebase';

const kResetphone = '$kBaseUrl/auth/reset-phone';
const kResetphoneFirebase = '$kBaseUrl/auth/reset-phone-firebase';

const kLogin = '$kBaseUrl/auth/login';
const kProviderLogin = '$kBaseUrl/provider-auth/login';
const kUpadetProvider = '$kBaseUrl/pharmacy/update-me';

const kUploadProviderPhoto = '$kBaseUrl/providers/update-me/upload-photo';
const kUploadProviderAttachment = '$kBaseUrl/providers/update-me/attachments';
const kDeleteProviderAttachment =
    '$kBaseUrl/providers/update-me/attachments/delete';
const kDeleteUserAttachment = '$kBaseUrl/users/update-me/attachments/delete';
const kLoginProvider = '$kBaseUrl/auth-pharmacy/login';
const kPhotosUrl = '$domain/img/attachments/';

const kGetMe = '$kBaseUrl/auth/me';
const kUsers = '$kBaseUrl/users/';
const kProviders = '$kBaseUrl/providers/';

const kgetSevices = '$kBaseUrl/service';
const kTimeslot = '$kBaseUrl/timeslot';
const kAds = '$kBaseUrl/ad';

const kApppointment = '$kBaseUrl/appointment';
const kSetting = '$kBaseUrl/settings';
const kComplainment = '$kBaseUrl/compainments';

const kAcceptAppointments = '$kApppointment/provider/accept/';
const kOnProccessingAppointments = '$kApppointment/provider/OnProcessing/';
const kDoneAppointments = '$kApppointment/provider/done/';
const kRate = '$kApppointment/rate';

const kUserPay = '$kApppointment/pay/';
const kPorividerPay = '$kApppointment/provider/pay/';

const kStartVideo = '$kApppointment/video/';

const kCreatePaymentLink = '$kApppointment/get_payment_link/';

const kGetMeProvider = '$kBaseUrl/auth/provider/get-me';

const kUpdateMe = '$kBaseUrl/users/update-me';
const kUUploadAttachment = '$kBaseUrl/users/update-me/attachments';
const kUUploadUserPhoto = '$kBaseUrl/users/update-me/upload-photo';

const kUpdateMeProvider = '$kBaseUrl/auth/provider/update-me';

const kUpdateCars = '$kBaseUrl/auth/update-me/cars';
const kUpdateAddresses = '$kBaseUrl/auth/update-me/addresses';

const kPackage = '$kBaseUrl/packages';

const kOrder = '$kBaseUrl/orders?byUser=true';
const kRequest = '$kBaseUrl/request';
const kNear = '$kBaseUrl/pharmacy/near';
const kSearch = '$kBaseUrl/pharmacy/search';

const kTop5 = '$kBaseUrl/pharmacy/top-5';
const kWith24 = '$kBaseUrl/pharmacy/with24';

String getPharmacyByUserUrl(String id) =>
    '$kBaseUrl/pharmacy/' + id + '/byUser';

//pharmacy/63fe4af642cb012dda16eec0/reviews/stats
String followUrll(String id) => '$kBaseUrl/pharmacy/' + id + '/follow';
String unfollowUrll(String id) => '$kBaseUrl/pharmacy/' + id + '/unfollow';
String kGetRatingStating(String id) =>
    '$kBaseUrl/pharmacy/' + id + '/reviews/stats';

// Categories
const kGetCategories = '$kBaseUrl/category';
// Categories
const kGetJobs = '$kBaseUrl/job';
String kGetJobsByCat(String id) => kGetJobs + '/byCat/' + id;

// pharmacy

// review
const kReview = '$kBaseUrl/review';
const kPost = '$kBaseUrl/posts';
