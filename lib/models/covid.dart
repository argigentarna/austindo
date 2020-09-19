class Covid {
  String objectIdFieldName;
  UniqueIdField uniqueIdField;
  String globalIdFieldName;
  String geometryType;
  SpatialReference spatialReference;
  List<Fields> fields;
  List<Features> features;

  Covid(
      {this.objectIdFieldName,
      this.uniqueIdField,
      this.globalIdFieldName,
      this.geometryType,
      this.spatialReference,
      this.fields,
      this.features});

  Covid.fromJson(Map<String, dynamic> json) {
    objectIdFieldName = json['objectIdFieldName'];
    uniqueIdField = json['uniqueIdField'] != null
        ? new UniqueIdField.fromJson(json['uniqueIdField'])
        : null;
    globalIdFieldName = json['globalIdFieldName'];
    geometryType = json['geometryType'];
    spatialReference = json['spatialReference'] != null
        ? new SpatialReference.fromJson(json['spatialReference'])
        : null;
    if (json['fields'] != null) {
      fields = new List<Fields>();
      json['fields'].forEach((v) {
        fields.add(new Fields.fromJson(v));
      });
    }
    if (json['features'] != null) {
      features = new List<Features>();
      json['features'].forEach((v) {
        features.add(new Features.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectIdFieldName'] = this.objectIdFieldName;
    if (this.uniqueIdField != null) {
      data['uniqueIdField'] = this.uniqueIdField.toJson();
    }
    data['globalIdFieldName'] = this.globalIdFieldName;
    data['geometryType'] = this.geometryType;
    if (this.spatialReference != null) {
      data['spatialReference'] = this.spatialReference.toJson();
    }
    if (this.fields != null) {
      data['fields'] = this.fields.map((v) => v.toJson()).toList();
    }
    if (this.features != null) {
      data['features'] = this.features.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UniqueIdField {
  String name;
  bool isSystemMaintained;

  UniqueIdField({this.name, this.isSystemMaintained});

  UniqueIdField.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isSystemMaintained = json['isSystemMaintained'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isSystemMaintained'] = this.isSystemMaintained;
    return data;
  }
}

class SpatialReference {
  int wkid;
  int latestWkid;

  SpatialReference({this.wkid, this.latestWkid});

  SpatialReference.fromJson(Map<String, dynamic> json) {
    wkid = json['wkid'];
    latestWkid = json['latestWkid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wkid'] = this.wkid;
    data['latestWkid'] = this.latestWkid;
    return data;
  }
}

class Fields {
  String name;
  String type;
  String alias;
  String sqlType;
  int length;
  Null domain;
  Null defaultValue;

  Fields(
      {this.name,
      this.type,
      this.alias,
      this.sqlType,
      this.length,
      this.domain,
      this.defaultValue});

  Fields.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    alias = json['alias'];
    sqlType = json['sqlType'];
    length = json['length'];
    domain = json['domain'];
    defaultValue = json['defaultValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['alias'] = this.alias;
    data['sqlType'] = this.sqlType;
    data['length'] = this.length;
    data['domain'] = this.domain;
    data['defaultValue'] = this.defaultValue;
    return data;
  }
}

class Features {
  Attributes attributes;

  Features({this.attributes});

  Features.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null) {
      data['attributes'] = this.attributes.toJson();
    }
    return data;
  }
}

class Attributes {
  int lastUpdate;
  int recovered;
  int deaths;
  int confirmed;

  Attributes({this.lastUpdate, this.recovered, this.deaths, this.confirmed});

  Attributes.fromJson(Map<String, dynamic> json) {
    lastUpdate = json['Last_Update'];
    recovered = json['Recovered'];
    deaths = json['Deaths'];
    confirmed = json['Confirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Last_Update'] = this.lastUpdate;
    data['Recovered'] = this.recovered;
    data['Deaths'] = this.deaths;
    data['Confirmed'] = this.confirmed;
    return data;
  }
}
