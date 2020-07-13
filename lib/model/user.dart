class User {
  int id;
  String name;
  String username;
  String state;
  String avatarUrl;
  String webUrl;
  String createdAt;
  String bio;
  String location;
  String publicEmail;
  String skype;
  String linkedin;
  String twitter;
  String websiteUrl;
  String organization;
  String jobTitle;
  String lastSignInAt;
  String confirmedAt;
  String lastActivityOn;
  String email;
  int themeId;
  int colorSchemeId;
  int projectsLimit;
  String currentSignInAt;
  bool canCreateGroup;
  bool canCreateProject;
  bool twoFactorEnabled;
  bool external;
  bool privateProfile;
  bool isAdmin;

  User(
      {this.id,
        this.name,
        this.username,
        this.state,
        this.avatarUrl,
        this.webUrl,
        this.createdAt,
        this.bio,
        this.location,
        this.publicEmail,
        this.skype,
        this.linkedin,
        this.twitter,
        this.websiteUrl,
        this.organization,
        this.jobTitle,
        this.lastSignInAt,
        this.confirmedAt,
        this.lastActivityOn,
        this.email,
        this.themeId,
        this.colorSchemeId,
        this.projectsLimit,
        this.currentSignInAt,
        this.canCreateGroup,
        this.canCreateProject,
        this.twoFactorEnabled,
        this.external,
        this.privateProfile,
        this.isAdmin});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    state = json['state'];
    avatarUrl = json['avatar_url'];
    webUrl = json['web_url'];
    createdAt = json['created_at'];
    bio = json['bio'];
    location = json['location'];
    publicEmail = json['public_email'];
    skype = json['skype'];
    linkedin = json['linkedin'];
    twitter = json['twitter'];
    websiteUrl = json['website_url'];
    organization = json['organization'];
    jobTitle = json['job_title'];
    lastSignInAt = json['last_sign_in_at'];
    confirmedAt = json['confirmed_at'];
    lastActivityOn = json['last_activity_on'];
    email = json['email'];
    themeId = json['theme_id'];
    colorSchemeId = json['color_scheme_id'];
    projectsLimit = json['projects_limit'];
    currentSignInAt = json['current_sign_in_at'];
    canCreateGroup = json['can_create_group'];
    canCreateProject = json['can_create_project'];
    twoFactorEnabled = json['two_factor_enabled'];
    external = json['external'];
    privateProfile = json['private_profile'];
    isAdmin = json['is_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['state'] = this.state;
    data['avatar_url'] = this.avatarUrl;
    data['web_url'] = this.webUrl;
    data['created_at'] = this.createdAt;
    data['bio'] = this.bio;
    data['location'] = this.location;
    data['public_email'] = this.publicEmail;
    data['skype'] = this.skype;
    data['linkedin'] = this.linkedin;
    data['twitter'] = this.twitter;
    data['website_url'] = this.websiteUrl;
    data['organization'] = this.organization;
    data['job_title'] = this.jobTitle;
    data['last_sign_in_at'] = this.lastSignInAt;
    data['confirmed_at'] = this.confirmedAt;
    data['last_activity_on'] = this.lastActivityOn;
    data['email'] = this.email;
    data['theme_id'] = this.themeId;
    data['color_scheme_id'] = this.colorSchemeId;
    data['projects_limit'] = this.projectsLimit;
    data['current_sign_in_at'] = this.currentSignInAt;
    data['can_create_group'] = this.canCreateGroup;
    data['can_create_project'] = this.canCreateProject;
    data['two_factor_enabled'] = this.twoFactorEnabled;
    data['external'] = this.external;
    data['private_profile'] = this.privateProfile;
    data['is_admin'] = this.isAdmin;
    return data;
  }
}