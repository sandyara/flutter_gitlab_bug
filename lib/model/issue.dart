class IssueResponse {
  int projectId;
  int id;
  String createdAt;
  int iid;
  String title;
  String state;
  String assignee;
  List<String> labels;
  int upvotes;
  int downvotes;
  int mergeRequestsCount;
  Author author;
  String description;
  String updatedAt;
  String closedAt;
  String closedBy;
  String milestone;
  bool subscribed;
  int userNotesCount;
  String dueDate;
  String webUrl;
  References references;
  TimeStats timeStats;
  bool confidential;
  bool discussionLocked;
  Links lLinks;
  TaskCompletionStatus taskCompletionStatus;

  IssueResponse(
      {this.projectId,
        this.id,
        this.createdAt,
        this.iid,
        this.title,
        this.state,
        this.assignee,
        this.labels,
        this.upvotes,
        this.downvotes,
        this.mergeRequestsCount,
        this.author,
        this.description,
        this.updatedAt,
        this.closedAt,
        this.closedBy,
        this.milestone,
        this.subscribed,
        this.userNotesCount,
        this.dueDate,
        this.webUrl,
        this.references,
        this.timeStats,
        this.confidential,
        this.discussionLocked,
        this.lLinks,
        this.taskCompletionStatus});

  IssueResponse.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    id = json['id'];
    createdAt = json['created_at'];
    iid = json['iid'];
    title = json['title'];
    state = json['state'];
    assignee = json['assignee'];
    labels = json['labels'].cast<String>();
    upvotes = json['upvotes'];
    downvotes = json['downvotes'];
    mergeRequestsCount = json['merge_requests_count'];
    author =
    json['author'] != null ? new Author.fromJson(json['author']) : null;
    description = json['description'];
    updatedAt = json['updated_at'];
    closedAt = json['closed_at'];
    closedBy = json['closed_by'];
    milestone = json['milestone'];
    subscribed = json['subscribed'];
    userNotesCount = json['user_notes_count'];
    dueDate = json['due_date'];
    webUrl = json['web_url'];
    references = json['references'] != null
        ? new References.fromJson(json['references'])
        : null;
    timeStats = json['time_stats'] != null
        ? new TimeStats.fromJson(json['time_stats'])
        : null;
    confidential = json['confidential'];
    discussionLocked = json['discussion_locked'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
    taskCompletionStatus = json['task_completion_status'] != null
        ? new TaskCompletionStatus.fromJson(json['task_completion_status'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['iid'] = this.iid;
    data['title'] = this.title;
    data['state'] = this.state;
    data['assignee'] = this.assignee;
    data['labels'] = this.labels;
    data['upvotes'] = this.upvotes;
    data['downvotes'] = this.downvotes;
    data['merge_requests_count'] = this.mergeRequestsCount;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['description'] = this.description;
    data['updated_at'] = this.updatedAt;
    data['closed_at'] = this.closedAt;
    data['closed_by'] = this.closedBy;
    data['milestone'] = this.milestone;
    data['subscribed'] = this.subscribed;
    data['user_notes_count'] = this.userNotesCount;
    data['due_date'] = this.dueDate;
    data['web_url'] = this.webUrl;
    if (this.references != null) {
      data['references'] = this.references.toJson();
    }
    if (this.timeStats != null) {
      data['time_stats'] = this.timeStats.toJson();
    }
    data['confidential'] = this.confidential;
    data['discussion_locked'] = this.discussionLocked;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    if (this.taskCompletionStatus != null) {
      data['task_completion_status'] = this.taskCompletionStatus.toJson();
    }
    return data;
  }
}

class Author {
  String name;
  String avatarUrl;
  String state;
  String webUrl;
  int id;
  String username;

  Author(
      {this.name,
        this.avatarUrl,
        this.state,
        this.webUrl,
        this.id,
        this.username});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatarUrl = json['avatar_url'];
    state = json['state'];
    webUrl = json['web_url'];
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar_url'] = this.avatarUrl;
    data['state'] = this.state;
    data['web_url'] = this.webUrl;
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}

class References {
  String short;
  String relative;
  String full;

  References({this.short, this.relative, this.full});

  References.fromJson(Map<String, dynamic> json) {
    short = json['short'];
    relative = json['relative'];
    full = json['full'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['short'] = this.short;
    data['relative'] = this.relative;
    data['full'] = this.full;
    return data;
  }
}

class TimeStats {
  int timeEstimate;
  int totalTimeSpent;
  Null humanTimeEstimate;
  Null humanTotalTimeSpent;

  TimeStats(
      {this.timeEstimate,
        this.totalTimeSpent,
        this.humanTimeEstimate,
        this.humanTotalTimeSpent});

  TimeStats.fromJson(Map<String, dynamic> json) {
    timeEstimate = json['time_estimate'];
    totalTimeSpent = json['total_time_spent'];
    humanTimeEstimate = json['human_time_estimate'];
    humanTotalTimeSpent = json['human_total_time_spent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_estimate'] = this.timeEstimate;
    data['total_time_spent'] = this.totalTimeSpent;
    data['human_time_estimate'] = this.humanTimeEstimate;
    data['human_total_time_spent'] = this.humanTotalTimeSpent;
    return data;
  }
}

class Links {
  String self;
  String notes;
  String awardEmoji;
  String project;

  Links({this.self, this.notes, this.awardEmoji, this.project});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    notes = json['notes'];
    awardEmoji = json['award_emoji'];
    project = json['project'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    data['notes'] = this.notes;
    data['award_emoji'] = this.awardEmoji;
    data['project'] = this.project;
    return data;
  }
}

class TaskCompletionStatus {
  int count;
  int completedCount;

  TaskCompletionStatus({this.count, this.completedCount});

  TaskCompletionStatus.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    completedCount = json['completed_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['completed_count'] = this.completedCount;
    return data;
  }
}