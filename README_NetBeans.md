# 🚇 Pune Metro Management App - NetBeans IDE Setup Guide

## Latest Version Compatibility

### ✅ **Supported Versions (2025)**
- **NetBeans IDE**: Apache NetBeans 19+ (Latest: 20+)
- **Java**: JDK 17+ (LTS), JDK 21+ (Latest LTS), JDK 23+ (Latest)
- **MySQL**: 8.0+ (Recommended: MySQL 8.3+)
- **MySQL Connector**: mysql-connector-j-8.2.0.jar (Latest J Series)

---

## 🏗️ **NetBeans Project Structure**

```
PuneMetroManagementApp/
├── nbproject/                    # NetBeans project files
│   ├── project.xml
│   ├── project.properties
│   └── build-impl.xml
├── src/                          # Source code
│   └── com/
│       └── punemetro/
│           ├── model/            # Data models
│           ├── dao/              # Data Access Objects  
│           ├── service/          # Business logic
│           ├── ui/               # NetBeans Forms (.java + .form)
│           ├── util/             # Utilities
│           └── exception/        # Custom exceptions
├── lib/                          # External JAR files
│   └── mysql-connector-j-8.2.0.jar
├── build/                        # Compiled classes (auto-generated)
├── dist/                         # Distribution JAR (auto-generated)
├── database/
│   └── pune_metro_database.sql   # Database schema
├── build.xml                     # Ant build script
└── README_NetBeans.md           # This file
```

---

## 🚀 **Quick Setup Instructions**

### **Step 1: Download Prerequisites**

1. **Apache NetBeans 19+**
   ```
   Download from: https://netbeans.apache.org/download/
   Choose: Java SE version (includes Swing support)
   ```

2. **Java JDK 17+ (Recommended: JDK 21)**
   ```
   Oracle JDK: https://www.oracle.com/java/technologies/downloads/
   OpenJDK: https://adoptium.net/
   ```

3. **MySQL 8.3+ Server**
   ```
   Download: https://dev.mysql.com/downloads/mysql/
   Choose: MySQL Community Server
   ```

4. **Latest MySQL Connector/J**
   ```
   Download: https://dev.mysql.com/downloads/connector/j/
   File: mysql-connector-j-8.2.0.jar
   ```

### **Step 2: Setup MySQL Database**

1. **Install and start MySQL Server**
2. **Create database and tables:**
   ```sql
   -- Execute the pune_metro_database.sql file
   mysql -u root -p < database/pune_metro_database.sql
   ```

3. **Verify database creation:**
   ```sql
   USE pune_metro_management;
   SHOW TABLES;
   SELECT COUNT(*) FROM stations; -- Should show 26 stations
   ```

### **Step 3: Configure NetBeans Project**

1. **Open NetBeans IDE**
2. **Create New Project:**
   - File → New Project
   - Categories: Java with Ant → Java Application
   - Project Name: `PuneMetroManagementApp`
   - Choose project location

3. **Import Source Files:**
   - Copy all `.java` files to `src/com/punemetro/` directories
   - Copy all `.form` files to same directories as corresponding `.java` files

4. **Add MySQL Driver:**
   - Right-click project → Properties
   - Libraries → Add JAR/Folder
   - Select `mysql-connector-j-8.2.0.jar`
   - Add to Compile-time Libraries

5. **Configure Project Properties:**
   - Right-click project → Properties
   - Sources → Set Source/Binary Format to JDK 17+
   - Build → Compiling → Set Java Platform to JDK 17+

### **Step 4: Database Configuration**

1. **Update database.properties:**
   ```properties
   db.url=jdbc:mysql://localhost:3306/pune_metro_management
   db.username=YOUR_MYSQL_USERNAME
   db.password=YOUR_MYSQL_PASSWORD
   ```

2. **Place properties file:**
   - Copy to `src/` root directory (not in packages)

### **Step 5: Build and Run**

1. **Clean and Build:**
   - Right-click project → Clean and Build
   - Check for compilation errors

2. **Set Main Class:**
   - Right-click project → Properties
   - Run → Main Class: `com.punemetro.ui.PuneMetroMainFrame`

3. **Run Application:**
   - Press F6 or click Run button
   - Application should start with GUI

---

## 🎨 **NetBeans Forms Features**

### **Visual Form Designer Benefits:**
- ✅ **Drag-and-Drop GUI Builder**
- ✅ **Visual Layout Managers** (GroupLayout, BorderLayout, etc.)
- ✅ **Property Inspector** for component customization
- ✅ **Event Handler Generation** (automatic method stubs)
- ✅ **Component Palette** with Swing controls
- ✅ **Preview Mode** for testing layouts
- ✅ **Internationalization Support**

### **Generated Files:**
- `.java` files: Contains your business logic + generated GUI code
- `.form` files: XML representation of the visual design
- **Note**: Never manually edit the generated GUI code sections

### **Key NetBeans Form Panels Created:**
1. **PuneMetroMainFrame.form** - Main application window
2. **SmartCardPanel.form** - Smart card creation form
3. **JourneyPanel.form** - Metro journey management
4. **RechargePanel.form** - Card recharge interface
5. **ReportsPanel.form** - Reports and analytics
6. **SystemLogPanel.form** - System logging display

---

## 🔧 **Advanced NetBeans Configuration**

### **JVM Arguments (for better performance):**
```
-Xms512m -Xmx2048m -Dfile.encoding=UTF-8
-Djava.awt.useSystemAAFontSettings=on
-Dswing.aatext=true
-Dsun.java2d.d3d=false
```

### **NetBeans IDE Settings:**
1. **Tools → Options → Java → Maven**
   - Set JDK Home to your Java 17+ installation

2. **Tools → Options → Appearance**
   - Choose Dark or Light theme
   - Set font size for better visibility

3. **Tools → Options → Editor → Code Completion**
   - Enable auto-completion features

### **Project Build Configuration:**
```xml
<!-- In nbproject/project.properties -->
javac.source=17
javac.target=17
platform.active=JDK_17
source.encoding=UTF-8
```

---

## 🎯 **NetBeans-Specific Features Used**

### **1. Visual Form Designer:**
- Created professional GUI layouts with GroupLayout
- Used Component Palette for Swing components
- Property Inspector for component customization

### **2. Event Handling:**
- Automatic event handler generation
- Clean separation of GUI and business logic

### **3. Code Generation:**
- Automatic getter/setter generation
- toString() method generation
- Constructor generation

### **4. Debugging:**
- Visual debugger with breakpoints
- Variable inspection
- Step-through debugging

### **5. Database Integration:**
- Services tab for database connections
- SQL Editor for database queries
- Visual database browser

---

## 🚦 **Running the Application**

### **Development Mode:**
1. Open NetBeans IDE
2. Open project folder
3. Press **F6** to run
4. Application launches with database connection test

### **Production Mode:**
1. Build project: **Shift+F11**
2. Navigate to `dist/` folder
3. Run JAR file:
   ```bash
   java -jar PuneMetroManagementApp.jar
   ```

### **Troubleshooting:**
- **Database Connection Issues**: Check MySQL service and credentials
- **Form Display Problems**: Verify .form files are in correct directories
- **Compilation Errors**: Ensure JDK 17+ is properly configured
- **Missing Icons**: Check resource folder paths

---

## 📱 **Application Features (NetBeans Forms)**

### **Smart Card Management:**
- Professional form layouts with validation
- Date picker for birth date
- Dropdown for gender selection
- Real-time card number generation

### **Journey Management:**
- Station selection with combo boxes
- Entry/Exit validation
- Real-time fare calculation
- Journey history display

### **Recharge System:**
- Amount validation with number formatting
- Payment method selection
- Transaction confirmation dialogs
- Balance update notifications

### **Reports & Analytics:**
- Tabular data display with JTable
- Search and filter capabilities
- Export functionality
- Graphical charts (with additional libraries)

---

## 🏆 **Performance Optimizations**

### **Database:**
- Connection pooling implementation
- Prepared statement caching
- Batch insert operations
- Index optimization

### **UI:**
- Lazy loading for large datasets
- Background thread for database operations
- Progress indicators for long operations
- Memory-efficient table models

### **Application:**
- Efficient exception handling
- Resource cleanup in finally blocks
- Proper logging implementation
- Configuration externalization

---

## 🔒 **Security Features**

### **Database Security:**
- SQL injection prevention with PreparedStatement
- Connection encryption options
- User authentication and authorization
- Input validation and sanitization

### **Application Security:**
- Form input validation
- Business rule enforcement
- Audit logging
- Error handling without information disclosure

---

## 📚 **Additional Resources**

### **NetBeans Documentation:**
- [NetBeans Platform Learning Trail](https://netbeans.apache.org/tutorial/)
- [Swing GUI Builder Guide](https://netbeans.apache.org/tutorial/nbm-gui.html)

### **Java 17+ Features Used:**
- Text blocks for SQL queries
- Pattern matching (if applicable)
- Records for data transfer objects
- Improved NullPointerException messages

### **MySQL 8.3+ Features:**
- JSON data types (for configuration)
- Common table expressions (CTEs)
- Window functions for analytics
- Improved performance schema

---

## 🎉 **Success Indicators**

After successful setup, you should see:
- ✅ Application starts without errors
- ✅ Database connection established message
- ✅ All 5 tabs functional (Smart Card, Journey, Recharge, Reports, Logs)
- ✅ Sample data loaded (26 stations, 5 sample cards)
- ✅ Professional GUI with NetBeans Forms styling
- ✅ Real-time logging in System Logs tab

**🚀 Your Pune Metro Management System is now ready for use with NetBeans IDE!**