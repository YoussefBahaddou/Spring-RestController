$projectRoot = "c:\DEV\Lechgar\DrissLechgarRepo\SeleniumScripts\downloads\TP-28 ( id 272 )\TP-28-SonarQube-local--main"
$srcMainJava = "$projectRoot\src\main\java"
$srcTestJava = "$projectRoot\src\test\java"
$oldPackagePath = "com\example\tp"
$newPackagePath = "com\youssef\clean"

# 1. Update POM
$pomPath = "$projectRoot\pom.xml"
if (Test-Path $pomPath) {
    (Get-Content $pomPath) -replace "com.example", "com.youssef" `
                           -replace "tp-junit-jacoco", "clean-utils" `
                           -replace "<name>TP JUnit \+ JaCoCo</name>", "<name>Clean Code Utils</name>" | Set-Content $pomPath
}

# 2. Prepare Directories
$newMainDir = "$srcMainJava\$newPackagePath"
$newTestDir = "$srcTestJava\$newPackagePath"
New-Item -ItemType Directory -Force -Path $newMainDir | Out-Null
New-Item -ItemType Directory -Force -Path $newTestDir | Out-Null

# 3. Move and Rename Main Files
$oldMainDir = "$srcMainJava\$oldPackagePath"
if (Test-Path $oldMainDir) {
    Move-Item "$oldMainDir\DateUtils.java" "$newMainDir\DateHelper.java" -Force -ErrorAction SilentlyContinue
    Move-Item "$oldMainDir\StringTools.java" "$newMainDir\TextProcessor.java" -Force -ErrorAction SilentlyContinue
}

# 4. Move and Rename Test Files
$oldTestDir = "$srcTestJava\$oldPackagePath"
if (Test-Path $oldTestDir) {
    Move-Item "$oldTestDir\DateUtilsTest.java" "$newTestDir\DateHelperTest.java" -Force -ErrorAction SilentlyContinue
    Move-Item "$oldTestDir\StringToolsTest.java" "$newTestDir\TextProcessorTest.java" -Force -ErrorAction SilentlyContinue
}

# 5. Remove Old Directories
Remove-Item "$srcMainJava\com\example" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$srcTestJava\com\example" -Recurse -Force -ErrorAction SilentlyContinue

# 6. Content Updates (Package, Imports, Class Names)
$javaFiles = Get-ChildItem -Path $projectRoot -Recurse -Filter *.java

foreach ($file in $javaFiles) {
    $content = Get-Content $file.FullName -Raw

    # Package update
    $content = $content -replace "package com.example.tp;", "package com.youssef.clean;"
    
    # Import updates (if any external usage existed, but here they are in same package usually)
    $content = $content -replace "import com.example.tp", "import com.youssef.clean"

    # Class Name renaming
    $content = $content -replace "DateUtils", "DateHelper" `
                        -replace "StringTools", "TextProcessor"

    # Clean comments
    $content = [Regex]::Replace($content, "/\*[\s\S]*?\*/", "")
    $content = [Regex]::Replace($content, "//.*", "")

    Set-Content -Path $file.FullName -Value $content
}

# 7. Create README
$readmeContent = "# Clean Code Utils

## Description
A utility library containing helpers for Date and Text processing, refactored by **Youssef Bahaddou**.
Demonstrates Unit Testing (JUnit 5) and Code Coverage (JaCoCo).

## Components
- **DateHelper**: Utilities for date manipulation.
- **TextProcessor**: Utilities for string processing.

## Testing
Run tests with coverage:
\`\`\`bash
mvn clean verify
\`\`\`
"
Set-Content -Path "$projectRoot\README.md" -Value $readmeContent

Write-Host "TP-28 Refactoring Complete!"
