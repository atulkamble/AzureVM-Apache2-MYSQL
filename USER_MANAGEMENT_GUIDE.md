# User Management System - Complete CRUD Operations

## 📋 Overview

This project now includes a complete **CRUD (Create, Read, Update, Delete)** system for managing users in the MySQL `webdb` database. All operations are performed on the `users` table.

## 🗂️ Database Structure

**Database:** `webdb`  
**Table:** `users`

```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## 📄 New PHP Pages

### 1. **manage_users.php** - View All Users
- **URL:** `http://your-vm-ip/manage_users.php`
- **Features:**
  - Display all users in a table format
  - Show total user count
  - Quick action buttons (Edit, Delete)
  - Links to add new users
  - Real-time statistics
- **Operations:** READ (List all records)

### 2. **add_user.php** - Add New User
- **URL:** `http://your-vm-ip/add_user.php`
- **Features:**
  - Form to enter name and email
  - Validation for required fields
  - Success/error messages
  - Automatic redirect options
- **Operations:** CREATE (Insert new record)

### 3. **edit_user.php** - Edit Existing User
- **URL:** `http://your-vm-ip/edit_user.php?id={user_id}`
- **Features:**
  - Pre-populated form with existing data
  - Update name and email
  - Display user ID and creation date
  - Validation and error handling
- **Operations:** UPDATE (Modify existing record)

### 4. **delete_user.php** - Delete User
- **URL:** `http://your-vm-ip/delete_user.php?id={user_id}`
- **Features:**
  - JavaScript confirmation dialog
  - Safe deletion with ID validation
  - Displays deleted user information
  - Prevents accidental deletions
- **Operations:** DELETE (Remove record)

## 🚀 How to Deploy

### Method 1: Using Terraform (Recommended)

All files are automatically deployed via `cloud-init.yaml`:

```bash
cd terraform
terraform apply
```

The cloud-init configuration will create:
- `index.php` (with links to all pages)
- `info.php`
- `db_test.php`
- `add_user.php`
- `manage_users.php`
- `edit_user.php`
- `delete_user.php`

### Method 2: Manual Deployment via Script

SSH into your VM and run:

```bash
sudo ./scripts/deploy_website.sh
```

This will deploy all files including the new user management pages.

### Method 3: Manual File Copy

Copy files from the `website/` directory to your VM:

```bash
# From your local machine
scp website/*.php azureuser@<your-vm-ip>:/tmp/

# On the VM
sudo mv /tmp/*.php /var/www/html/
sudo chown www-data:www-data /var/www/html/*.php
sudo chmod 644 /var/www/html/*.php
```

## 🔐 Database Credentials

**Location:** Hardcoded in each PHP file (change for production!)

```php
$servername = "localhost";
$username = "webuser";
$password = "webpass123";
$database = "webdb";
```

**⚠️ Security Warning:** In production, use environment variables or configuration files!

## 📊 Features Overview

| Feature | Page | HTTP Method | SQL Operation |
|---------|------|-------------|---------------|
| List all users | `manage_users.php` | GET | SELECT |
| View user details | `manage_users.php` | GET | SELECT |
| Add new user | `add_user.php` | POST | INSERT |
| Edit user | `edit_user.php` | GET/POST | SELECT/UPDATE |
| Delete user | `delete_user.php` | GET | DELETE |

## 🎨 UI/UX Features

✅ Responsive design  
✅ Modern gradient backgrounds  
✅ Hover effects on cards and buttons  
✅ Color-coded success/error messages  
✅ Confirmation dialogs for destructive operations  
✅ Breadcrumb navigation  
✅ Real-time statistics dashboard  
✅ Mobile-friendly layout  

## 🔄 User Workflow

### Adding a User
1. Click "Add User" from home page or "Manage Users"
2. Fill in name and email
3. Click "Add User"
4. View success message
5. Navigate to "View All Users" or back to home

### Editing a User
1. Go to "Manage Users"
2. Click "✏️ Edit" button for desired user
3. Modify name or email
4. Click "💾 Update User"
5. View success message

### Deleting a User
1. Go to "Manage Users"
2. Click "🗑️ Delete" button
3. Confirm deletion in popup
4. View deletion confirmation

## 📝 Sample Data

The database is pre-populated with 3 sample users:

1. John Doe - john@example.com
2. Jane Smith - jane@example.com
3. Bob Johnson - bob@example.com

## 🔧 Customization

### Changing Database Credentials

Edit each PHP file and update the connection variables:

```php
$servername = "localhost";  // Database server
$username = "your_user";    // Database user
$password = "your_pass";    // Database password
$database = "your_db";      // Database name
```

### Adding More Fields

To add more fields to the users table:

1. **Update MySQL table:**
```sql
ALTER TABLE users ADD COLUMN phone VARCHAR(20);
```

2. **Update PHP forms** (add_user.php, edit_user.php):
```html
<div class="form-group">
    <label for="phone">Phone:</label>
    <input type="tel" id="phone" name="phone">
</div>
```

3. **Update SQL queries:**
```php
$sql = "INSERT INTO users (name, email, phone) VALUES ('$name', '$email', '$phone')";
```

## 🐛 Troubleshooting

### Database Connection Failed
```bash
# Check MySQL is running
sudo systemctl status mysql

# Verify database exists
sudo mysql -u root -p
SHOW DATABASES;
USE webdb;
SHOW TABLES;
```

### Permission Denied
```bash
# Fix file permissions
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
```

### PHP Not Working
```bash
# Enable PHP module
sudo a2enmod php
sudo systemctl restart apache2

# Check PHP is installed
php -v
```

## 📱 Testing

### Test Database Connection
Visit: `http://your-vm-ip/db_test.php`

### Test CRUD Operations
1. **Create:** Add a test user via `add_user.php`
2. **Read:** View all users in `manage_users.php`
3. **Update:** Edit the test user via `edit_user.php?id=X`
4. **Delete:** Remove the test user via delete button

## 🔒 Security Considerations

⚠️ **Important for Production:**

1. **Use Prepared Statements** (prevent SQL injection):
```php
$stmt = $conn->prepare("INSERT INTO users (name, email) VALUES (?, ?)");
$stmt->bind_param("ss", $name, $email);
$stmt->execute();
```

2. **Add Authentication** (restrict access)
3. **Use HTTPS** (encrypt data transmission)
4. **Validate Input** (both client and server-side)
5. **Store Credentials Securely** (use environment variables)
6. **Add CSRF Protection** (prevent cross-site request forgery)
7. **Implement Rate Limiting** (prevent abuse)

## 📚 API-like Usage

While these are web pages, you can also interact programmatically:

### Add User (via cURL)
```bash
curl -X POST http://your-vm-ip/add_user.php \
  -d "name=Test User" \
  -d "email=test@example.com"
```

### Delete User (via cURL)
```bash
curl http://your-vm-ip/delete_user.php?id=5
```

## 🎯 Next Steps

- [ ] Add user authentication/login system
- [ ] Implement pagination for large user lists
- [ ] Add search and filter functionality
- [ ] Export users to CSV/Excel
- [ ] Add user profile pictures
- [ ] Implement soft delete (mark as deleted instead of removing)
- [ ] Add audit logs (track who made changes)
- [ ] Create REST API endpoints
- [ ] Add email verification
- [ ] Implement password reset functionality

## 📖 Resources

- [PHP MySQL Documentation](https://www.php.net/manual/en/book.mysqli.php)
- [SQL Injection Prevention](https://www.php.net/manual/en/security.database.sql-injection.php)
- [Bootstrap for Better UI](https://getbootstrap.com/)
- [AJAX for Dynamic Updates](https://api.jquery.com/jquery.ajax/)

## 🤝 Contributing

Feel free to enhance these pages by:
- Adding more validation
- Improving UI/UX
- Adding new features
- Fixing security issues
- Optimizing queries

---

**Version:** 1.0  
**Last Updated:** 2025-11-02  
**Database:** MySQL  
**Framework:** Native PHP (no frameworks)  
**License:** MIT
