//
//  TopicsMockJSON.swift
//  NetworkingTests
//
//  Created by Tobi Kuyoro on 06/10/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

let topics = """
[
    {
      "createdDate": "2020-09-24 13:00:28",
      "lastModifiedDate": "2020-09-24 13:00:28",
      "topicId": 37,
      "title": "Topic 2",
      "owner": {
        "createdDate": "2020-09-24 13:00:22",
        "lastModifiedDate": "2020-09-24 13:00:22",
        "userid": 4,
        "username": "admin"
      },
      "frequency": "MONDAY",
      "defaultsurvey": {
        "createdDate": "2020-09-24 13:00:28",
        "lastModifiedDate": "2020-09-24 13:00:28",
        "surveyid": 36,
        "questions": [],
        "responded": false,
        "surveyId": 36
      },
      "joincode": "YzNL0yaW6",
      "surveysrequests": [
        {
          "createdDate": "2020-09-24 13:00:29",
          "lastModifiedDate": "2020-09-24 13:00:29",
          "surveyid": 46,
          "questions": [
            {
              "createdDate": "2020-09-24 13:00:29",
              "lastModifiedDate": "2020-09-24 13:00:29",
              "body": "Leader Question 1",
              "type": "TEXT",
              "answers": [],
              "leader": true,
              "questionId": 56
            },
            {
              "createdDate": "2020-09-24 13:00:29",
              "lastModifiedDate": "2020-09-24 13:00:29",
              "body": "Leader Question 2",
              "type": "TEXT",
              "answers": [],
              "leader": true,
              "questionId": 58
            },
            {
              "createdDate": "2020-09-24 13:00:29",
              "lastModifiedDate": "2020-09-24 13:00:29",
              "body": "Member Question 1",
              "type": "TEXT",
              "answers": [],
              "leader": false,
              "questionId": 59
            }
          ],
          "responded": false,
          "surveyId": 46
        },
        {
          "createdDate": "2020-09-24 13:00:29",
          "lastModifiedDate": "2020-09-24 13:00:29",
          "surveyid": 57,
          "questions": [],
          "responded": false,
          "surveyId": 57
        }
      ],
      "users": [
        {
          "createdDate": "2020-09-24 13:00:28",
          "lastModifiedDate": "2020-09-24 13:00:28",
          "user": {
            "createdDate": "2020-09-24 13:00:22",
            "lastModifiedDate": "2020-09-24 13:00:22",
            "userid": 5,
            "username": "cinnamon"
          }
        },
        {
          "createdDate": "2020-09-24 13:00:28",
          "lastModifiedDate": "2020-09-24 13:00:28",
          "user": {
            "createdDate": "2020-09-24 13:00:22",
            "lastModifiedDate": "2020-09-24 13:00:22",
            "userid": 10,
            "username": "llama001@maildrop.cc"
          }
        },
        {
          "createdDate": "2020-09-24 16:10:08",
          "lastModifiedDate": "2020-09-24 16:10:08",
          "user": {
            "createdDate": "2020-09-24 16:08:07",
            "lastModifiedDate": "2020-09-24 16:08:07",
            "userid": 98,
            "username": "llama002@maildrop.cc"
          }
        },
        {
          "createdDate": "2020-10-01 13:16:03",
          "lastModifiedDate": "2020-10-01 13:16:03",
          "user": {
            "createdDate": "2020-10-01 13:16:03",
            "lastModifiedDate": "2020-10-01 13:16:03",
            "userid": 270,
            "username": "llama004@maildrop.cc"
          }
        }
      ]
    }
]

""".data(using: .utf8)!

let surveys = """
[
    {
      "createdDate": "2020-09-24 13:00:28",
      "lastModifiedDate": "2020-09-24 13:00:28",
      "surveyid": 36,
      "topic": null,
      "questions": [],
      "responded": false,
      "surveyId": 36
    },
    {
      "createdDate": "2020-09-24 13:00:29",
      "lastModifiedDate": "2020-09-24 13:00:29",
      "surveyid": 47,
      "topic": {
        "createdDate": "2020-09-24 13:00:28",
        "lastModifiedDate": "2020-09-24 13:00:28",
        "topicId": 39,
        "title": "Topic 3",
        "joincode": "bqQdl5Ygl"
      },
      "questions": [
        {
          "createdDate": "2020-09-24 13:00:29",
          "lastModifiedDate": "2020-09-24 13:00:29",
          "body": "Member Question 2",
          "type": "TEXT",
          "answers": [],
          "questionId": 60,
          "leader": false
        },
        {
          "createdDate": "2020-09-24 13:00:29",
          "lastModifiedDate": "2020-09-24 13:00:29",
          "body": "Member Question 3",
          "type": "TEXT",
          "answers": [],
          "questionId": 61,
          "leader": false
        }
      ],
      "responded": false,
      "surveyId": 47
    },
    {
      "createdDate": "2020-09-24 13:00:29",
      "lastModifiedDate": "2020-09-24 13:00:29",
      "surveyid": 48,
      "topic": {
        "createdDate": "2020-09-24 13:00:28",
        "lastModifiedDate": "2020-09-24 13:00:28",
        "topicId": 41,
        "title": "Topic 4",
        "joincode": "0vY3OJ03G"
      },
      "questions": [],
      "responded": false,
      "surveyId": 48
    }
]
""".data(using: .utf8)!

let questions = """
[
    {
      "createdDate": "2020-09-24 13:00:29",
      "lastModifiedDate": "2020-09-24 13:00:29",
      "body": "Leader Question 1",
      "type": "TEXT",
      "survey": {
        "createdDate": "2020-09-24 13:00:29",
        "lastModifiedDate": "2020-09-24 13:00:29",
        "surveyid": 46,
        "responded": false,
        "surveyId": 46
      },
      "answers": [],
      "questionId": 56,
      "leader": true
    },
    {
      "createdDate": "2020-09-24 13:00:29",
      "lastModifiedDate": "2020-09-24 13:00:29",
      "body": "Leader Question 2",
      "type": "TEXT",
      "survey": {
        "createdDate": "2020-09-24 13:00:29",
        "lastModifiedDate": "2020-09-24 13:00:29",
        "surveyid": 46,
        "responded": false,
        "surveyId": 46
      },
      "answers": [],
      "questionId": 58,
      "leader": true
    }
]
""".data(using: .utf8)!

let contexts = """
[
    {
      "createdDate": "2020-09-24 13:00:29",
      "lastModifiedDate": "2020-09-24 13:00:29",
      "description": "product leadership",
      "survey": {
        "createdDate": "2020-09-24 13:00:29",
        "lastModifiedDate": "2020-09-24 13:00:29",
        "surveyid": 46,
        "questions": [
          {
            "createdDate": "2020-09-24 13:00:29",
            "lastModifiedDate": "2020-09-24 13:00:29",
            "body": "Leader Question 1",
            "type": "TEXT",
            "answers": [],
            "questionId": 56,
            "leader": true
          },
          {
            "createdDate": "2020-09-24 13:00:29",
            "lastModifiedDate": "2020-09-24 13:00:29",
            "body": "Leader Question 2",
            "type": "TEXT",
            "answers": [],
            "questionId": 58,
            "leader": true
          },
          {
            "createdDate": "2020-09-24 13:00:29",
            "lastModifiedDate": "2020-09-24 13:00:29",
            "body": "Member Question 1",
            "type": "TEXT",
            "answers": [],
            "questionId": 59,
            "leader": false
          }
        ],
        "responded": false,
        "surveyId": 46
      },
      "contextId": 51
    },
    {
      "createdDate": "2020-09-24 13:00:29",
      "lastModifiedDate": "2020-09-24 13:00:29",
      "description": "delivery management",
      "survey": {
        "createdDate": "2020-09-24 13:00:29",
        "lastModifiedDate": "2020-09-24 13:00:29",
        "surveyid": 47,
        "questions": [
          {
            "createdDate": "2020-09-24 13:00:29",
            "lastModifiedDate": "2020-09-24 13:00:29",
            "body": "Member Question 2",
            "type": "TEXT",
            "answers": [],
            "questionId": 60,
            "leader": false
          },
          {
            "createdDate": "2020-09-24 13:00:29",
            "lastModifiedDate": "2020-09-24 13:00:29",
            "body": "Member Question 3",
            "type": "TEXT",
            "answers": [],
            "questionId": 61,
            "leader": false
          }
        ],
        "responded": false,
        "surveyId": 47
      },
      "contextId": 52
    },
    {
      "createdDate": "2020-09-24 13:00:29",
      "lastModifiedDate": "2020-09-24 13:00:29",
      "description": "project management",
      "survey": {
        "createdDate": "2020-09-24 13:00:29",
        "lastModifiedDate": "2020-09-24 13:00:29",
        "surveyid": 48,
        "questions": [],
        "responded": false,
        "surveyId": 48
      },
      "contextId": 53
    },
    {
      "createdDate": "2020-09-24 13:00:29",
      "lastModifiedDate": "2020-09-24 13:00:29",
      "description": "design leadership",
      "survey": {
        "createdDate": "2020-09-24 13:00:29",
        "lastModifiedDate": "2020-09-24 13:00:29",
        "surveyid": 49,
        "questions": [],
        "responded": false,
        "surveyId": 49
      },
      "contextId": 54
    }
]

""".data(using: .utf8)!
