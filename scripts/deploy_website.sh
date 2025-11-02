#!/bin/bash

###############################################################################
# Script: deploy_website.sh
# Description: Deploy sample website files to Apache document root
# Usage: sudo ./deploy_website.sh
###############################################################################

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Website Deployment Script${NC}"
echo -e "${GREEN}========================================${NC}"

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}Please run as root (use sudo)${NC}"
    exit 1
fi

WEB_ROOT="/var/www/html"
BACKUP_DIR="/var/www/html_backup_$(date +%Y%m%d_%H%M%S)"

# Backup existing website
if [ -d "$WEB_ROOT" ]; then
    echo -e "\n${YELLOW}[1/4] Backing up existing website to $BACKUP_DIR...${NC}"
    mkdir -p "$BACKUP_DIR"
    cp -r $WEB_ROOT/* "$BACKUP_DIR/" 2>/dev/null || true
fi

# Remove default index.html
echo -e "\n${YELLOW}[2/4] Removing default files...${NC}"
rm -f $WEB_ROOT/index.html

# Create index.php
echo -e "\n${YELLOW}[3/4] Creating website files...${NC}"
cat > $WEB_ROOT/index.php <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Azure VM - Apache2 & MySQL</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-width: 800px;
            width: 100%;
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
            text-align: center;
            font-size: 2.5em;
        }
        .status {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
        }
        .status-item {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            border-bottom: 1px solid #dee2e6;
        }
        .status-item:last-child { border-bottom: none; }
        .label { font-weight: bold; color: #495057; }
        .value { color: #28a745; }
        .links {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 30px;
        }
        .link-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-decoration: none;
            text-align: center;
            transition: transform 0.3s;
        }
        .link-card:hover { transform: translateY(-5px); }
        .footer {
            text-align: center;
            margin-top: 30px;
            color: #6c757d;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 Welcome to Azure VM</h1>
        <div class="status">
            <div class="status-item">
                <span class="label">Server:</span>
                <span class="value">✓ Apache2 Running</span>
            </div>
            <div class="status-item">
                <span class="label">Language:</span>
                <span class="value">✓ PHP <?php echo PHP_VERSION; ?></span>
            </div>
            <div class="status-item">
                <span class="label">Hostname:</span>
                <span class="value"><?php echo gethostname(); ?></span>
            </div>
            <div class="status-item">
                <span class="label">Server IP:</span>
                <span class="value"><?php echo $_SERVER['SERVER_ADDR']; ?></span>
            </div>
            <div class="status-item">
                <span class="label">Current Time:</span>
                <span class="value"><?php echo date('Y-m-d H:i:s'); ?></span>
            </div>
        </div>
        
        <div class="links">
            <a href="info.php" class="link-card">
                <h3>📋 PHP Info</h3>
                <p>View PHP configuration</p>
            </a>
            <a href="db_test.php" class="link-card">
                <h3>🗄️ Database Test</h3>
                <p>Test MySQL connection</p>
            </a>
            <a href="manage_users.php" class="link-card">
                <h3>👥 Manage Users</h3>
                <p>View, edit & delete users</p>
            </a>
            <a href="add_user.php" class="link-card">
                <h3>➕ Add User</h3>
                <p>Add new user to database</p>
            </a>
        </div>
        
        <div class="footer">
            <p>Powered by Azure VM | Apache2 | MySQL | PHP</p>
        </div>
    </div>
</body>
</html>
EOF
            margin-top: 30px;
        }
        .link-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-decoration: none;
            text-align: center;
            transition: transform 0.3s;
        }
        .link-card:hover { transform: translateY(-5px); }
        .footer {
            text-align: center;
            margin-top: 30px;
            color: #6c757d;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 Welcome to Azure VM</h1>
        <div class="status">
            <div class="status-item">
                <span class="label">Server:</span>
                <span class="value">✓ Apache2 Running</span>
            </div>
            <div class="status-item">
                <span class="label">Language:</span>
                <span class="value">✓ PHP <?php echo PHP_VERSION; ?></span>
            </div>
            <div class="status-item">
                <span class="label">Hostname:</span>
                <span class="value"><?php echo gethostname(); ?></span>
            </div>
            <div class="status-item">
                <span class="label">Server IP:</span>
                <span class="value"><?php echo $_SERVER['SERVER_ADDR']; ?></span>
            </div>
            <div class="status-item">
                <span class="label">Current Time:</span>
                <span class="value"><?php echo date('Y-m-d H:i:s'); ?></span>
            </div>
        </div>
        
        <div class="links">
            <a href="info.php" class="link-card">
                <h3>📋 PHP Info</h3>
                <p>View PHP configuration</p>
            </a>
            <a href="db_test.php" class="link-card">
                <h3>🗄️ Database Test</h3>
                <p>Test MySQL connection</p>
            </a>
        </div>
        
        <div class="footer">
            <p>Powered by Azure VM | Apache2 | MySQL | PHP</p>
        </div>
    </div>
</body>
</html>
EOF

# Create info.php
cat > $WEB_ROOT/info.php <<'EOF'
<?php
phpinfo();
?>
EOF

# Create db_test.php
cat > $WEB_ROOT/db_test.php <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MySQL Database Test</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-width: 1000px;
            margin: 20px auto;
        }
        h1 { color: #333; margin-bottom: 20px; text-align: center; }
        h2 { color: #667eea; margin: 20px 0; }
        .success { color: #28a745; padding: 15px; background: #d4edda; border-radius: 5px; margin: 20px 0; }
        .error { color: #dc3545; padding: 15px; background: #f8d7da; border-radius: 5px; margin: 20px 0; }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: bold;
        }
        tr:hover { background-color: #f5f5f5; }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .back-link:hover { background: #764ba2; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🗄️ MySQL Database Connection Test</h1>
        
        <?php
        $servername = "localhost";
        $username = "webuser";
        $password = "webpass123";
        $database = "webdb";
        
        // Create connection
        $conn = new mysqli($servername, $username, $password, $database);
        
        // Check connection
        if ($conn->connect_error) {
            echo '<div class="error">';
            echo '<h2>❌ Connection Failed!</h2>';
            echo '<p>Error: ' . $conn->connect_error . '</p>';
            echo '</div>';
        } else {
            echo '<div class="success">';
            echo '<h2>✅ MySQL Connection Successful!</h2>';
            echo '<p><strong>Connected to database:</strong> ' . $database . '</p>';
            echo '<p><strong>Server version:</strong> ' . $conn->server_info . '</p>';
            echo '</div>';
            
            // Display data from test table
            $sql = "SELECT * FROM users";
            $result = $conn->query($sql);
            
            if ($result->num_rows > 0) {
                echo '<h2>Users in Database:</h2>';
                echo '<table>';
                echo '<tr><th>ID</th><th>Name</th><th>Email</th><th>Created At</th></tr>';
                while($row = $result->fetch_assoc()) {
                    echo '<tr>';
                    echo '<td>' . htmlspecialchars($row["id"]) . '</td>';
                    echo '<td>' . htmlspecialchars($row["name"]) . '</td>';
                    echo '<td>' . htmlspecialchars($row["email"]) . '</td>';
                    echo '<td>' . htmlspecialchars($row["created_at"]) . '</td>';
                    echo '</tr>';
                }
                echo '</table>';
            } else {
                echo '<p>No users found in the database.</p>';
            }
            
            $conn->close();
        }
        ?>
        
        <a href="index.php" class="back-link">← Back to Home</a>
    </div>
</body>
</html>
EOF

# Copy user management files from website directory if they exist
if [ -d "../website" ]; then
    echo -e "\n${YELLOW}Copying user management files...${NC}"
    [ -f "../website/add_user.php" ] && cp ../website/add_user.php $WEB_ROOT/
    [ -f "../website/manage_users.php" ] && cp ../website/manage_users.php $WEB_ROOT/
    [ -f "../website/edit_user.php" ] && cp ../website/edit_user.php $WEB_ROOT/
    [ -f "../website/delete_user.php" ] && cp ../website/delete_user.php $WEB_ROOT/
fi

# Set proper permissions
echo -e "\n${YELLOW}[4/4] Setting permissions...${NC}"
chown -R www-data:www-data $WEB_ROOT
chmod -R 755 $WEB_ROOT

# Get public IP
PUBLIC_IP=$(curl -s ifconfig.me 2>/dev/null || echo "Unable to detect")

echo -e "\n${GREEN}========================================${NC}"
echo -e "${GREEN}Deployment Summary${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "Document Root: ${YELLOW}$WEB_ROOT${NC}"
echo -e "Backup Location: ${YELLOW}$BACKUP_DIR${NC}"
echo -e "Public IP: ${YELLOW}$PUBLIC_IP${NC}"
echo -e "\n${GREEN}Access your website at:${NC}"
echo -e "  ${YELLOW}http://$PUBLIC_IP${NC} - Home Page"
echo -e "  ${YELLOW}http://$PUBLIC_IP/info.php${NC} - PHP Info"
echo -e "  ${YELLOW}http://$PUBLIC_IP/db_test.php${NC} - Database Test"
echo -e "  ${YELLOW}http://$PUBLIC_IP/manage_users.php${NC} - Manage Users"
echo -e "  ${YELLOW}http://$PUBLIC_IP/add_user.php${NC} - Add New User"
echo -e "${GREEN}========================================${NC}"

echo -e "\n${GREEN}✓ Website deployment completed successfully!${NC}\n"
