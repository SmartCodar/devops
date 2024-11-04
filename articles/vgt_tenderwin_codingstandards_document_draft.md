# Virtual Globe Technologies - TenderWin.ai Coding Standards Document

## Table of Contents
1. [General Guidelines](#general-guidelines)
2. [Naming Conventions](#naming-conventions)
3. [Code Length and Complexity](#code-length-and-complexity)
4. [Language-Specific Guidelines](#language-specific-guidelines)
5. [Error Handling and Logging](#error-handling-and-logging)
6. [Security Best Practices](#security-best-practices)
7. [Code Reviews and Testing](#code-reviews-and-testing)
8. [Documentation](#documentation)
9. [API Request and Response Standards](#api-request-and-response-standards)

---

### 1. General Guidelines
- **Code Readability:** Ensure code is clear and easy to understand, with an emphasis on readability over conciseness.
- **Comments:** Add comments to explain complex logic. Avoid obvious comments (e.g., `x = 5` does not require a comment).
- **Version Control:** Commit frequently with clear, concise messages describing changes.

---

### 2. Naming Conventions

#### Variables and Attributes
- Use **snake_case** for Python, Node.js, and MySQL variables.
- Use **kebab-case** for HTML attributes.

#### Class Names
- Use **PascalCase** for class names (e.g., `UserAccount`).

#### Function and Method Names
- **snake_case** for Python; **camelCase** for JavaScript.

#### Constants
- **ALL_CAPS** for constants (e.g., `MAX_RETRY_LIMIT`).

---

### 3. Code Length and Complexity

#### Method Length
- Limit methods and functions to **50 lines**. Refactor if needed to maintain focus.

#### API Endpoint Handlers
- Limit API endpoint handlers to **100 lines**. Separate complex logic into helper functions.

---

### 4. Language-Specific Guidelines

#### Python
- **Error Handling:** Use `try-except` blocks and log specific exceptions.
- **Logging:** Use `logging` library with `logging.error()` for structured error logging.
- **PEP 8 Compliance:** Use tools like `black` for formatting.

Example:
```python
import logging

class UserAccount:
    def __init__(self, user_name: str):
        self.user_name = user_name

    def get_user_info(self):
        try:
            # Fetch user info
            pass
        except Exception as e:
            logging.error("Error in get_user_info: %s", e, exc_info=True)
```

#### Node.js
- **Error Handling:** Use `try-catch` for synchronous code and `.catch()` for Promises.
- **Logging:** Use `console.error` for errors or a library like `winston` for production.

Example:
```javascript
const getUserInfo = async (userId) => {
    try {
        const user = await fetchUser(userId);
        return user;
    } catch (error) {
        console.error("Error in getUserInfo:", error);
    }
};
```

#### MySQL
- **Table Naming:** Use `snake_case` (e.g., `user_account`).
- **Error Handling:** Log SQL errors with context for debugging.

Example:
```sql
CREATE TABLE user_account (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### MongoDB
- **Collection Naming:** Use `snake_case` (e.g., `user_accounts`).
- **Field Naming:** Use `camelCase`.

Example:
```javascript
const userSchema = new mongoose.Schema({
    userName: String,
    createdAt: { type: Date, default: Date.now }
});
```

#### HTML
- **Attribute Naming:** Use `kebab-case` for attributes (e.g., `data-user-id`).
- **CSS Classes:** Use `kebab-case` for class names.

Example:
```html
<div class="user-card" data-user-id="123" aria-label="User profile card">
    <p>User Name</p>
</div>
```

---

### 5. Error Handling and Logging

- **Request and Response Logging:** Log each request and response, ensuring no sensitive data is logged.
- **Error Logging:** Log complete error messages and stack traces.
- **Log Levels:** Use levels (INFO, WARNING, ERROR) to categorize log severity.

Example (Node.js Logging):
```javascript
app.post('/api/users', async (req, res) => {
    console.info("Request received:", req.body);

    try {
        const user = await createUser(req.body);
        console.info("Response sent:", user);
        res.status(201).send(user);
    } catch (error) {
        console.error("Error in /api/users:", error);
        res.status(500).send({ error: "Internal Server Error" });
    }
});
```

---

### 6. Security Best Practices

- **Input Validation:** Validate inputs to avoid SQL injection.
- **Environment Variables:** Store sensitive information in environment variables.
- **HTTPS:** Use HTTPS for secure communication.
- **Access Control:** Enforce access control on APIs and database queries.

---

### 7. Code Reviews and Testing

- **Code Reviews:** Regular code reviews to ensure standards and best practices.
- **Unit Tests:** Write unit tests for critical logic in Python and Node.js.
- **Integration Tests:** Test API flows to catch issues early.

---

### 8. Documentation

- **Function Documentation:** Describe each function’s purpose, parameters, and return values.
- **API Documentation:** Keep API documentation up-to-date.

---

### 9. API Request and Response Standards

#### Request Standards
- **Content-Type:** Use `application/json` for JSON payloads and `application/x-www-form-urlencoded` for form submissions.
- **Authorization Header:** Include `Authorization: Bearer <token>` for token-based authentication.
- **Cookies:** Avoid using cookies for sensitive data transmission. When required, set `Secure` and `HttpOnly` attributes.
- **Request Headers:** Avoid passing sensitive data like PCI (credit card numbers), PII (personally identifiable information), or DOB in headers. Use secure methods to transmit these values.
- **Query Strings:** Do not pass sensitive information such as PCI, PII, or passwords in query strings. Limit query strings to non-sensitive data (e.g., pagination, filters).
- **Request Body:** For sensitive data, encrypt values if required by compliance standards (e.g., PCI-DSS for payment data).

#### Response Standards
- **HTTP Codes:** Follow standard HTTP codes:
  - **200** - OK (Successful GET/POST)
  - **201** - Created (Resource creation)
  - **400** - Bad Request (Invalid client request)
  - **401** - Unauthorized (Authentication required or failed)
  - **403** - Forbidden (Client lacks permissions)
  - **404** - Not Found (Resource does not exist)
  - **500** - Internal Server Error (Server encountered an error)
- **Content-Type:** Set `Content-Type: application/json` for JSON responses.
- **Response Headers:** Do not include sensitive information in headers. For any additional headers, use secure methods.
- **Sensitive Data in Responses:**
  - Mask or omit sensitive information like IDs, PCI data, PII (such as email and phone), and DOB in responses.
  - Provide user-friendly error messages without exposing stack traces or internal system details.
- **Error Responses:** Structure error responses with an error code, message, and details if safe.
  ```json
  {
      "error": {
          "code": "USER_NOT_FOUND",
          "message": "The specified user does not exist."
      }
  }
  ```

#### Logging Sensitive Data
- **Request and Response Logging:** Mask sensitive fields (e.g., passwords, tokens) in logs to prevent exposure.
- **Compliance (PCI, PII):** Adhere to standards by avoiding storage or transmission of PCI and PII in logs or unprotected formats.

---

This document serves as a guide to maintain consistency and quality across projects. Following these standards will ensure better readability, maintainability, and security of the codebase.
