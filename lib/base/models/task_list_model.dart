class TaskListModel {
  bool? status;
  String? message;
  String? tag;
  String? errorCode;
  List<Result>? result;
  bool? hasResult;

  TaskListModel(
      {this.status,
      this.message,
      this.tag,
      this.errorCode,
      this.result,
      this.hasResult});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    tag = json['tag'];
    errorCode = json['errorCode'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    hasResult = json['hasResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['tag'] = this.tag;
    data['errorCode'] = this.errorCode;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['hasResult'] = this.hasResult;
    return data;
  }
}

class Result {
  Page? page;
  Filter? filter;
  List<Tasks>? tasks;

  Result({this.page, this.filter, this.tasks});

  Result.fromJson(Map<String, dynamic> json) {
    page = json['page'] != null ? new Page.fromJson(json['page']) : null;
    filter =
        json['filter'] != null ? new Filter.fromJson(json['filter']) : null;
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.page != null) {
      data['page'] = this.page!.toJson();
    }
    if (this.filter != null) {
      data['filter'] = this.filter!.toJson();
    }
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Page {
  int? pageNumber;
  int? pageSize;
  int? totalPages;

  Page({this.pageNumber, this.pageSize, this.totalPages});

  Page.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Filter {
  int? taskType;
  int? taskPriority;
  int? taskStatus;
  int? taskAssignee;

  Filter(
      {this.taskType, this.taskPriority, this.taskStatus, this.taskAssignee});

  Filter.fromJson(Map<String, dynamic> json) {
    taskType = json['taskType'];
    taskPriority = json['taskPriority'];
    taskStatus = json['taskStatus'];
    taskAssignee = json['taskAssignee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskType'] = this.taskType;
    data['taskPriority'] = this.taskPriority;
    data['taskStatus'] = this.taskStatus;
    data['taskAssignee'] = this.taskAssignee;
    return data;
  }
}

class Tasks {
  int? taskId;
  String? title;
  String? description;
  int? doctorId;
  String? doctorName;
  int? practiceLocationId;
  String? practiceLocationName;
  int? assigneeId;
  String? assigneeName;
  int? taskPriorityId;
  String? taskPriorityName;
  int? taskCategoryId;
  String? taskCategoryName;
  int? taskStatusId;
  String? taskStatusName;
  String? lastUpdateStatusTime;
  String? taskCreateDate;

  Tasks(
      {this.taskId,
      this.title,
      this.description,
      this.doctorId,
      this.doctorName,
      this.practiceLocationId,
      this.practiceLocationName,
      this.assigneeId,
      this.assigneeName,
      this.taskPriorityId,
      this.taskPriorityName,
      this.taskCategoryId,
      this.taskCategoryName,
      this.taskStatusId,
      this.taskStatusName,
      this.lastUpdateStatusTime,
      this.taskCreateDate});

  Tasks.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    title = json['title'];
    description = json['description'];
    doctorId = json['doctorId'];
    doctorName = json['doctorName'];
    practiceLocationId = json['practiceLocationId'];
    practiceLocationName = json['practiceLocationName'];
    assigneeId = json['assigneeId'];
    assigneeName = json['assigneeName'];
    taskPriorityId = json['taskPriorityId'];
    taskPriorityName = json['taskPriorityName'];
    taskCategoryId = json['taskCategoryId'];
    taskCategoryName = json['taskCategoryName'];
    taskStatusId = json['taskStatusId'];
    taskStatusName = json['taskStatusName'];
    lastUpdateStatusTime = json['lastUpdateStatusTime'];
    taskCreateDate = json['taskCreateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskId'] = this.taskId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['doctorId'] = this.doctorId;
    data['doctorName'] = this.doctorName;
    data['practiceLocationId'] = this.practiceLocationId;
    data['practiceLocationName'] = this.practiceLocationName;
    data['assigneeId'] = this.assigneeId;
    data['assigneeName'] = this.assigneeName;
    data['taskPriorityId'] = this.taskPriorityId;
    data['taskPriorityName'] = this.taskPriorityName;
    data['taskCategoryId'] = this.taskCategoryId;
    data['taskCategoryName'] = this.taskCategoryName;
    data['taskStatusId'] = this.taskStatusId;
    data['taskStatusName'] = this.taskStatusName;
    data['lastUpdateStatusTime'] = this.lastUpdateStatusTime;
    data['taskCreateDate'] = this.taskCreateDate;
    return data;
  }
}
