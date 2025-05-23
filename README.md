# stock-market-management-system

## Description
The Stock Market Management System is a web-based application designed to help users manage their investments in stocks effectively. This project provides functionalities for both users and admins, allowing users to view available stocks, make investments, track their portfolio performance, and manage payments. Users can buy or invest in available stocks, while admins can manage stock listings and view all transactions.

## Technologies Used
- **Languages**: Java, JSP, HTML, CSS, JavaScript
- **Database**: MySQL
- **Frameworks**: Bootstrap
- **Libraries**: jQuery, MySQL Connector/J
- **Externals Jars**: mysql-connector-java-8.0.11
- **Server**: Apache Tomcat 10.1.33
- **IDE**: Eclipse IDE

## Features
- **User Role**: 
  - User registration and login
  - View available stocks
  - Buy/invest in stocks
  - Make stock investments and payments
  - View their transaction history
  - Calculate investment amounts
  - Track portfolio performance
- **Admin Role**:
  - Manage stock listings
  - View all transactions
  - Monitor user accounts

## Installation Instructions
1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/pruthvi-m-y/stock-market-management-system.git
2. Open the project in Eclipse IDE.
3. Project Structure
   Ensure your project follows this structure:
   stock-market-management-system/
    └── src/
        └── main/
            └── webapp/
                ├── front.html
                ├── admin_login.jsp
                ├── admin_logout.jsp
                └── assets/ (if any)

4. Set up Apache Tomcat 10.1.33 as the server.
5. Configure the MySQL Connector/J:
   • Download the mysql-connector-java-8.0.11.jar       file if not already included.

   • Place the JAR file in the lib folder of            Apache Tomcat (apache-tomcat/lib/).
   
   • Alternatively, add it to your project by:
   
   • Right-click on the project → Build Path →  Add External JARs → Select mysql-connector-java-8.0.11.jar.
   
6. Import the database from the provided SQL file into MySQL.
7. Run the project by opening front.html as the main page.
