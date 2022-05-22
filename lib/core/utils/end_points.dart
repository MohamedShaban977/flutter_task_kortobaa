//base url local server
// const String BASE_URL='http://pioneers-server:5050/api';

const String BASE_URL = 'http://192.168.1.2:5050/'; // ip local server
// const String BASE_URL = 'http://192.168.1.43:4200/';  // debug with backend
// const String BASE_URL = 'http://45.242.9.149:5050/api/'; // global
// const String BASE_URL = 'http://88.218.95.227:5050/'; // smarter global

const String Google_Map_Api_Key = "AIzaSyAnxW-zFqA30DJIlrbtBJgBtvQmtWgbwu0";
const String MAPS_BASE_URL = "https://maps.google.com/?q=";

const int TIMEOUT = 30;

/// Login Api
// Login step 1
const String LOGIN = 'api/AuthVolunteers/SendSMSCodeForLogin';
//Login Step 2  Send Verification code
const String LOGIN_SEND_VERIFICATION_CODE =
    'api/AuthVolunteers/VerificationSMSCodeForLogin';
//(Optional)  Login Step 2  ReSend Verification code
const String LOGIN_ERSEND_VERIFICATION_CODE =
    'api/AuthVolunteers/ReSendSMSCodeForLogin';
// Accept Privacy
const String ACCEPT_PRIVACY = "api/auth/AcceptPrivacy";

// Forget password
const String CHECK_NATIONAL_ID = "api/AuthVolunteers/CheckUserNationalId";
const String SEND_SNS_CODE_FOR_FORGET_PASSWORD =
    "api/AuthVolunteers/SendSMSCodeForForgetPassword";

const String VERIFY_SMS_CODE =
    "api/AuthVolunteers/VerificationSMSCodeForForgetPassword";
const String RESET_PASSWORD = "api/AuthVolunteers/ResetPassword";

// Registration Apis
const String CHECK_NATIONAL_ID_REGISTRATION =
    "api/VolunteerRegister/CheckUserNationalId";
const String VERIFY_SMS_CODE_Registration =
    "api/VolunteerRegister/VerificationSMSCodeForRegistration";
const String REGISTER_VOLUNTEER_MAIN_DATA =
    "api/VolunteerRegister/RegisterVolunteerMainData";
const String CHECK_PHONE_UNIQUE_FOR_REGISTRATION =
    "api/VolunteerRegister/CheckPhoneUniqueForRegistration";
const String CHECK_EMAIL_UNIQUE = "api/AuthVolunteers/CheckEmailUnique";

const String SOCIAL_LINKS = "api/VolunteerRegister/AddVolunteerSocailLinks";
const String ADD_VOLUNTEER_PROFESSIONAL =
    "api/VolunteerRegister/AddVolunteerProfessional";
const String ADD_VOLUNTEER_SKILLS =
    "api/VolunteerRegister/AddVolunteerSkillsAndInterests";
const String ADD_HEALTH_DATA = "api/VolunteerRegister/AddHealthyVolunteerData";

const String GET_LOOKUP_BY_CATEGORY =
    "api/VolunteerRegister/GetLookupVolunteerByCategory/";
const String GET_Master_BY_CATEGORY =
    "api/VolunteerRegister/VolunteerGetMasterDataByCategory/";
const String GET_QUALIFICATIONS =
    "api/Qualification/GetFirstLevelQualificationsVolunteerDropDown";
const String GET_INTERESTS_FIELDS_DROPDOWN =
    "api/VolunteerRegister/AdminGetFieldsDropDown";

// Edit profile urls
const String GET_VOLUNTEER_MAIN_DATA = "api/VolunteerProfile/VolunteerMainData";
const String GET_VOLUNTEER_SOCIAL_LINKS =
    "api/VolunteerProfile/VolunteerSocialMedia";
const String EDIT_VOLUNTEER_MAIN_DATA =
    "api/VolunteerProfile/EditVolunteerMainData";
const String EDIT_VOLUNTEER_SOCIAL_LINKS =
    "api/VolunteerProfile/EditVolunteerSocailLinks";
const String EDIT_PROFESSIONAL_DATA =
    "api/VolunteerProfile/EditVolunteerProfessionalData";

const String REED_CV = 'api/EditProfile/ReadCV';
const String GET_VOLUNTEER_PROFESSIONAL =
    "api/VolunteerProfile/GetVolunteerProfessionalData";
const String GET_VOLUNTEER_HEALTH_DATA =
    "api/VolunteerProfile/GetVolunteerHealthIndicatorData";
const String EDIT_VOLUNTEER_HEALTH =
    "api/VolunteerProfile/EditHealthyVolunteerData";
const String GET_VOLUNTEER_SKILLS_DATA =
    "api/VolunteerProfile/GetVolunteerSkills";
const String EDIT_VOLUNTEER_SKILLS = "api/VolunteerProfile/EditVolunteerSkills";
const String CHANGE_PASSWORD = "api/VolunteerProfile/ChangeVolunteerPassword";
const String CHANGE_EMAIL = "api/EditProfile/ChangeEmail";
const String GET_PROFILE_DATA = "api/VolunteerProfile/ReadProfileImage";
const String UPDATE_PROFILE_IMAGE = "api/VolunteerProfile/UploadProfileImage";
const String GET_NOTIFICATION_SETTING =
    "api/Notification/GetUserNotificationSetting";
const String EDIT_NOTIFICATION_SETTING =
    "api/Notification/EditUserNotificationSetting";

const String GET_OPPORTUNITIES =
    "api/VolunteerOpportunity/OppertunityGridByFilter";
const String GET_OPPORTUNITY_DETAILS =
    "api/VolunteerOpportunity/OppertunityDetails";
const String GET_OPPORTUNITY_PARENT_SHIFTS =
    "api/VolunteerOpportunity/GetOpportunityParentShifts/";
const String VOLUNTEER_JOIN_OPPORTUNITY =
    "api/VolunteerOpportunity/VolunteerJoinOpportunity";
const String TEAM_LEADER_INVITE_MEMBERS_JOIN_OPPORTUNITY =
    "api/VolunteerOpportunity/TeamLeaderInviteVolunteerJoinOpportunity";
const String GET_VOLUNTEER_JOINED_OPPORTUNITIES =
    "api/VolunteerArchive/GetJoinedOppertunitiesByFilter";
const String VOLUNTEER_LEAVE_OPPORTUNITY =
    "api/VolunteerOpportunity/VolunteerLeaveOpportunity";
const String GET_OPPORTUNITY_EVALUATION_QUESTIONS =
    "api/VolunteerEvaluateOpportunity/EvaluateVolunteerQuestins";
const String SEND_Opportunity_FEEDBACK =
    "api/VolunteerEvaluateOpportunity/EvaluationAnswersSubmit";
const String GET_VOLUNTEER_OPP_CERTIFICATE =
    "api/VolunteerCertificate/PrivateCertificate/";

const String GET_NOTIFICATIONS = "api/Notification/GetNotifications";
const String STATUS_SEEN_GET_NOTIFICATIONS =
    'api/Notification/NotificationStatus';

/// Teams Api
const String GET_ALL_TEAMS = "api/Team/GetTeamsForVolunteer";
const String GET_MEMBER_AND_LEADER = 'api/TeamMembers/GetTeamsForTeamMember';
const String JOIN_OR_CANCEL_TEAM_REQUEST =
    'api/Team/VolunteerJoinOrCancelTeamRequest/';
const String GET_TEAM_DETAILS = 'api/Team/GetTeamDetailsForVolunteer';
const String GET_TEAM_DETAILS_FOR_TeamLeader = 'api/TeamMembers/GetTeamDetailsForTeamLeader';
const String GET_LEADER_TEAM_MEMBERS = "api/TeamMembers/GetLeaderTeamMembers";

const String CAPTCHA_TEST =
    '03AGdBq27kcKY-YlzRoCHAlUXDAnqEvxsnErwywb7TFOq_B3qzlW5vU__lEdvwxHWq_wfJQDbEAeae0j62D-JXrwEgc5q0AeaCUjm7ZqNPfIF-biaxamlR4ppGpNwLIV9gudsvHMkAednZ42mgllrL50AcdQXNa1_Wa3uMtMc82H_GRZD2Z4Hocibb_0_3UIX-FMHSYoY9J4tyWJT8q8zvRkzrNFAfbMF3ZsadLsXVhQy88zl-klhL6VGlrctBx_w3IrauzOC3u1ijNfNx_DlS2cVBnz5cugq3oHXpfVpUNwrSUFmWuhnTLAET-IRUhKhNSd6O6MeP6vrNP0966YV-ramviHn92Qm2noov52gbWK81V0ncUCOtd4ySaihXGGrYwEMUO-Js9C5FGSNTFC2OTkBk6ht1zO5aBgWMGlX0GeF8A5UQ4rmKd0EOWfHp46I0fjvLbhtMNoTD';

const String REGIONS = 'api/VolunteerRegister/GetRegions';
const String CITIES_BY_REGION =
    'api/VolunteerRegister/GetCitiesByRegionId?RegionId=';
const String GET_CITITES_BY_REGION_IDS = "api/City/AdminGetCitiesByRegionIds";

const String LOGOUT = 'api/auth/logout';

/// Get Volunteer Today Shifts
const String GET_VOLUNTEER_TODAY_SHIFTS =
    'api/OpportunityAttendance/GetVolunteerTodayShifts';
const String VOLUNTEER_SHIFT_CHECK_IN =
    'api/OpportunityAttendance/VolunteerShiftCheckIn/';
const String VOLUNTEER_SHIFT_CHECK_OUT =
    'api/OpportunityAttendance/VolunteerShiftCheckOut/';

//////////////////////////////////////////////////////
///Volunteer  Invitation And Request Opportunity
/////////////////////////////////////////////////////
///Get Volunteer Invitation and Request
const String GET_VOLUNTEER_INVITATION_AND_REQUEST =
    'api/OpportunityManagment/GetVolunteerInvitaionAndRequest';

/// Get Opportunity Parent Shifts By Invitation Id
const String GET_OPPORTUNITY_PARENT_SHIFTS_BY_INVITATION_ID =
    'api/OpportunityManagment/GetOpportunityParentShiftsByInvitaionId';

/// Volunteer Reject Invitation
const String VOLUNTEER_REJECT_INVITATION =
    'api/OpportunityManagment/VolunteerRejectInvitaion';

/// Volunteer Accept Invitation
const String VOLUNTEER_ACCEPT_INVITATION =
    'api/OpportunityManagment/VolunteerAceeptInvitaion';

const String GET_VOLUNTEER_STATISTICS =
    "api/VolunteerArchive/GetJoinedOppertunitiesStatistics";
const String GET_VOLUNTEER_ACHIEVEMENT = "api/Medals/GetVolunteerAchivement";

const String GET_VOLUNTEER_GENERAL_CERTIFICATE =
    "api/VolunteerCertificate/PublicCertificate";
const String GET_VOLUNTEER_JOINED_OPPORTUNITIES_PDF =
    "api/VolunteerArchive/GetJoinedOppertunitiesHistoryPDF";

const String GET_ENTITY_EVALUATION_QUESTIONS =
    "api/VolunteerEvaluateEntity/EvaluateVolunteerQuestins";
const String SEND_ENTITY_FEEDBACK =
    "api/VolunteerEvaluateEntity/EvaluationAnswersSubmit";
const String GET_ENTITIES = "api/VolunteerEntityArchive/GetAllEntitiesByFilter";
const String GET_ENTITIES_BY_CITY_ID = "api/CommunityNeeds/GetCityEntitiesData";
const String GET_ENTITY_DETAILS =
    "api/VolunteerEntityArchive/GetEntityStatisticsDetails/";
const String GET_ENTITY_CHILD_ENTITIES =
    "api/VolunteerEntityArchive/GetEntityChildEntities/";

const String GET_TEAMS_VOLUNTEER_INVITATION_AND_REQUESTS =
    'api/Request/GetVolunteerRequests';
const String REPLY_BACK_TEAM_INVITATIONS_AND_REQUESTS =
    'api/Request/VolunteerReplyBackTeamRequestsAndInvitations';
const String GET_ENTITY_OPPORTUNITIES =
    "api/VolunteerEntityArchive/GetEntityApprovedOppertunitiesHistory";
const String ADD_ENTITY_TO_FAVOURITES =
    "api/VolunteerEntityFavourite/AddEntityToFavourite/";
const String REMOVE_ENTITY_FROM_FAVOURITES =
    "api/VolunteerEntityFavourite/RemoveEntityFromFavourite/";

const String GET_ENTITIES_AUTO_COMPLETE =
    'api/entities/GetEntitiesAutoComplete';

const String GET_VOLUNTEER = 'api/Volunteer/GetVolunteer';

const String ADD_TEAM_WITH_MEMBERS = 'api/Team/VolunteerAddTeamWithMembers';

const String GET_IDEAS =
    "api/VolunteerIdea/GetVolunteerIdeaToVolunteerByFilterModal";
const String ADD_IDEA = "api/VolunteerIdea/CreateVolunteerIdea";

const String CANCEL_JOIN_OPPORTUNITY_REQUEST =
    "api/VolunteerOpportunity/VolunteerCancelJoinOpportunityRequestById";

/// Edit Team Data Details
const String GET_TEAM_DETAILS_FOR_UPDATE = 'api/Team/GetTeamDetailsForUpdate';
const String UPDATE_TEAM_DETAILS = 'api/Team/UpdateTeamDetails';

/// Edit Team Members
const String GET_TEAM_MEMBERS = 'api/TeamMembers/GetTeamMembers';
const String VOLUNTEER_ADD_TEAM_MEMBERS =
    'api/TeamMembers/VolunteerAddTeamMember';
const String ASSIGN_TEAM_LEADER = 'api/TeamMembers/AssignTeamLeader';
const String ASSIGN_TEAM_LEADER_VICE = 'api/TeamMembers/AssignTeamLeaderVice';
const String DELETE_TEAM_MEMBER = 'api/TeamMembers/DeleteTeamMember';
const String JOIN_TEAMS_REQUESTS = 'api/Team/AcceptAndRefuseJoinTeamsRequests';

const String ADD_IDEA_TO_FAVOURITES =
    "api/VolunteerIdea/VolunteerAddIdeaToFavourite/";
const String REMOVE_IDEA_FROM_FAVOURITES =
    "api/VolunteerIdea/VolunteerRemoveIdeaFromFavourite/";
const String SHARE_IDEA = "api/VolunteerIdea/VolunteerShareIdea/";
const String GET_IDEA_DETAILS = "api/VolunteerIdea/DetailsVolunteerIdea";
const String GET_IDEA_DETAILS_FOR_EDIT =
    "api/VolunteerIdea/GetVolunteerIdeaById";
const String UPDATE_IDEA = "api/VolunteerIdea/UpdateVolunteerIdea";

const String UPLOAD_ACHIEVEMENTS = "api/TeamAttachments/UploadAchivements";
const String DELETE_ACHIEVEMENTS = "api/TeamAttachments/DeleteAchivement";
const String GET_ACHIEVEMENTS = "api/TeamAttachments/GetAchivements";

const String GET_ENTITY_INVITATIONS =
    'api/Invitation/GetVolunteerEntityInvitations';
const String REPLY_BACK_ENTITY_INVITATION =
    'api/Invitation/VolunteerReplyBackEntityInvitation';

const String GET_ALL_MEDALS = "api/Medals/VolunteerGetAllMedals";
const String GET_MEDAL_CERTIFICATE = "api/VolunteersMedals/MedalCertificate";

const String GET_ALL_COMMUNITY_NEEDS =
    "api/CommunityNeeds/VolunteerGetAllCommunityNeeds";
const String ADD_COMMUNITY_NEED = "api/CommunityNeeds/AddCommunityNeed";
const String GET_NEED_DETAILS_FOR_EDIT =
    "api/CommunityNeeds/VolunteerGetCommunityNeedForEdit";
const String EDIT_COMMUNITY_NEED =
    "api/CommunityNeeds/VolunteerEditCommunityNeed";

const String GET_ALL_EVENTS = "api/Event/GetAllEventsToVolunteer";
const String GET_EVENT_DETAILS = "api/Event/GetEventDetailsToVolunteer/";
const String GET_COMMUNITY_NEED_DETAILS =
    "api/CommunityNeeds/VolunteerGetCommunityNeedDetails/";

const String REMOVE_PROFILE_PIC = "api/EditProfile/DeleteProfileImage";

/// register student Registration
const String STUDENT_REGISTRATION_CHECK_NATIONAL_ID =
    'api/StudentRegisteration/CheckUserNationalId';
const String VERIFICATION_SMS_CODE_FOR_STUDENT_REGISTRATION =
    'api/StudentRegisteration/VerificationSMSCodeForStudentRegistration';
const String REGISTER_STUDENT_MAIN_DATA =
    'api/StudentRegisteration/RegisterStudentMainData';
const String GET_SCHOOL_FOR_REGISTRARION =
    'api/StudentRegisteration/GetSchoolsForRegistration';
const String REGISTER_STUDENT_SCHOOL_DATA =
    'api/StudentRegisteration/RegisterStudentSchoolData';
const String GET_PARENT_DATA = 'api/StudentRegisteration/GetParentData';
const String APPROVE_PARENT_DATA = 'api/StudentRegisteration/ApproveParentData';
const String VERIFICATION_SMS_CODE_APPROVE_PARENT =
    'api/StudentRegisteration/VerificationSMSCodeForApproveParentData';
const String GET_STUDENT_OPPORTUNITIES =
    "api/SchoolOpportunity/GetOppertunitiesByFilter";
const String STUDENT_JOIN_OPP = "api/SchoolOpportunity/StudentJoinOpportunity";
