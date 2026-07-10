# REST API Fundamentals – Study Project

![Status](https://img.shields.io/badge/Status-Completed-success)
![REST API](https://img.shields.io/badge/REST-API-blue)
![HTTP](https://img.shields.io/badge/HTTP-Methods-orange)
![Business Analysis](https://img.shields.io/badge/IT-Business%20Analysis-6f42c1)
![Learning Project](https://img.shields.io/badge/Project-Learning-brightgreen)

## Overview

This repository contains a simple REST API project created as part of a hands-on learning exercise focused on understanding how RESTful services work.

The project demonstrates the core concepts of REST APIs through practical examples of creating, retrieving, updating, and deleting resources using standard HTTP methods.

Although intentionally simple, the project reflects concepts frequently encountered by IT Business Analysts, Functional Analysts, QA Engineers, and Software Developers when working with backend services and system integrations.

---

## Objectives

- Understand REST architecture principles
- Learn how HTTP requests and responses work
- Practice CRUD operations
- Interpret HTTP status codes
- Test API endpoints using the VS Code REST Client
- Become familiar with API documentation and endpoint validation

---

## Technologies

- REST API
- HTTP
- JSON
- VS Code
- REST Client Extension
- GitHub

---

## API Endpoints

| Method | Endpoint | Description |
|---------|----------|-------------|
| GET | `/` | API health check |
| GET | `/users` | Retrieve all users |
| GET | `/users/{id}` | Retrieve a specific user |
| POST | `/users` | Create a new user |
| PUT | `/users/{id}` | Replace an existing user |
| PATCH | `/users/{id}` | Partially update a user |
| DELETE | `/users/{id}` | Delete a user |
| GET | `/books` | Retrieve all books |

---

## CRUD Operations

### Create

```http
POST /users
```

Creates a new user resource.

Example payload:

```json
{
  "name": "Jane Smith",
  "email": "jane@example.com",
  "address": "456 Oak Ave",
  "phoneNumber": "5556667777"
}
```

---

### Read

```http
GET /users
GET /users/{id}
```

Retrieves one or multiple user resources.

---

### Update

#### Full Update

```http
PUT /users/{id}
```

Example payload:

```json
{
  "name": "Nathaniel Cayden",
  "email": "nathaniel@example.com",
  "address": "5432 Street",
  "phoneNumber": "5555555555"
}
```

#### Partial Update

```http
PATCH /users/{id}
```

Example payload:

```json
{
  "phoneNumber": "5559876543",
  "address": "42 Other Avenue"
}
```

---

### Delete

```http
DELETE /users/{id}
```

Removes an existing user resource.

---

## Learning Outcomes

Through this project I gained practical experience with:

- REST architecture
- HTTP methods (GET, POST, PUT, PATCH, DELETE)
- CRUD operations
- Resource endpoints
- Request and response lifecycle
- JSON payloads
- HTTP status codes
- API testing using the VS Code REST Client
- Reading and interacting with API documentation

---

## Why this Project?

Modern IT Business Analysts frequently collaborate with software engineers, QA teams, solution architects, and product owners. Understanding how REST APIs work is essential for:

- Writing clearer functional requirements
- Supporting system integrations
- Validating API behavior during testing
- Communicating effectively with development teams
- Understanding AI and cloud-based application integrations

This project was created to strengthen these technical fundamentals through practical exercises.

---

## Repository Structure

```
.
├── requests.http      # REST Client requests used for testing
├── README.md
```

---

## Sample Requests

Retrieve all users:

```http
GET /users
```

Retrieve a specific user:

```http
GET /users/{id}
```

Create a new user:

```http
POST /users
Content-Type: application/json
```

Update an existing user:

```http
PUT /users/{id}
```

Partially update a user:

```http
PATCH /users/{id}
```

Delete a user:

```http
DELETE /users/{id}
```

---

## Skills Demonstrated

- REST APIs
- HTTP Protocol
- API Testing
- CRUD Operations
- JSON
- VS Code REST Client
- Git & GitHub
- Technical Documentation
- Business Analysis Foundations
- System Integration Fundamentals

---

> **Note**
>
> This repository was created for educational purposes as part of a hands-on REST API fundamentals course. Its goal is to reinforce the concepts commonly used in modern software development and IT Business Analysis.
