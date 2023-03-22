class NewTaskModel {
  bool? status;
  String? message;
  String? tag;
  String? errorCode;
  List<Result>? result;
  bool? hasResult;

  NewTaskModel(
      {this.status,
      this.message,
      this.tag,
      this.errorCode,
      this.result,
      this.hasResult});

  NewTaskModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? title;
  String? description;
  int? type;
  int? doctorId;
  String? doctorName;
  int? practiceLocation;
  String? practiceLocationName;
  int? status;
  String? statusName;
  int? priority;
  String? priorityName;
  int? assignedTo;
  String? assignedToName;
  int? assignedBy;
  String? assignedByName;
  int? createdBy;
  String? createdByName;
  List<TaskProducts>? taskProducts;
  List<TaskSubTasks>? taskSubTasks;
  List<TaskLog>? taskLog;

  Result(
      {this.id,
      this.title,
      this.description,
      this.type,
      this.doctorId,
      this.doctorName,
      this.practiceLocation,
      this.practiceLocationName,
      this.status,
      this.statusName,
      this.priority,
      this.priorityName,
      this.assignedTo,
      this.assignedToName,
      this.assignedBy,
      this.assignedByName,
      this.createdBy,
      this.createdByName,
      this.taskProducts,
      this.taskSubTasks,
      this.taskLog});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    doctorId = json['doctorId'];
    doctorName = json['doctorName'];
    practiceLocation = json['practiceLocation'];
    practiceLocationName = json['practiceLocationName'];
    status = json['status'];
    statusName = json['statusName'];
    priority = json['priority'];
    priorityName = json['priorityName'];
    assignedTo = json['assignedTo'];
    assignedToName = json['assignedToName'];
    assignedBy = json['assignedBy'];
    assignedByName = json['assignedByName'];
    createdBy = json['createdBy'];
    createdByName = json['createdByName'];
    if (json['taskProducts'] != null) {
      taskProducts = <TaskProducts>[];
      json['taskProducts'].forEach((v) {
        taskProducts!.add(new TaskProducts.fromJson(v));
      });
    }
    if (json['taskSubTasks'] != null) {
      taskSubTasks = <TaskSubTasks>[];
      json['taskSubTasks'].forEach((v) {
        taskSubTasks!.add(new TaskSubTasks.fromJson(v));
      });
    }
    if (json['taskLog'] != null) {
      taskLog = <TaskLog>[];
      json['taskLog'].forEach((v) {
        taskLog!.add(new TaskLog.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['doctorId'] = this.doctorId;
    data['doctorName'] = this.doctorName;
    data['practiceLocation'] = this.practiceLocation;
    data['practiceLocationName'] = this.practiceLocationName;
    data['status'] = this.status;
    data['statusName'] = this.statusName;
    data['priority'] = this.priority;
    data['priorityName'] = this.priorityName;
    data['assignedTo'] = this.assignedTo;
    data['assignedToName'] = this.assignedToName;
    data['assignedBy'] = this.assignedBy;
    data['assignedByName'] = this.assignedByName;
    data['createdBy'] = this.createdBy;
    data['createdByName'] = this.createdByName;
    if (this.taskProducts != null) {
      data['taskProducts'] = this.taskProducts!.map((v) => v.toJson()).toList();
    }
    if (this.taskSubTasks != null) {
      data['taskSubTasks'] = this.taskSubTasks!.map((v) => v.toJson()).toList();
    }
    if (this.taskLog != null) {
      data['taskLog'] = this.taskLog!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskProducts {
  int? taskId;
  int? productId;
  String? productName;

  TaskProducts({this.taskId, this.productId, this.productName});

  TaskProducts.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    productId = json['productId'];
    productName = json['productName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskId'] = this.taskId;
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    return data;
  }
}

class TaskSubTasks {
  int? taskId;
  int? subTaskId;
  String? subTaskName;
  String? remarks;

  TaskSubTasks({this.taskId, this.subTaskId, this.subTaskName, this.remarks});

  TaskSubTasks.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    subTaskId = json['subTaskId'];
    subTaskName = json['subTaskName'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskId'] = this.taskId;
    data['subTaskId'] = this.subTaskId;
    data['subTaskName'] = this.subTaskName;
    data['remarks'] = this.remarks;
    return data;
  }
}

class TaskLog {
  int? taskId;
  int? taskStatus;
  String? taskStatusName;
  String? eventDate;
  int? latitude;
  int? longitude;
  int? eventPerformedBy;

  TaskLog(
      {this.taskId,
      this.taskStatus,
      this.taskStatusName,
      this.eventDate,
      this.latitude,
      this.longitude,
      this.eventPerformedBy});

  TaskLog.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    taskStatus = json['taskStatus'];
    taskStatusName = json['taskStatusName'];
    eventDate = json['eventDate'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    eventPerformedBy = json['eventPerformedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskId'] = this.taskId;
    data['taskStatus'] = this.taskStatus;
    data['taskStatusName'] = this.taskStatusName;
    data['eventDate'] = this.eventDate;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['eventPerformedBy'] = this.eventPerformedBy;
    return data;
  }
}
