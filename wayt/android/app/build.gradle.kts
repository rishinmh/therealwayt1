plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.wayt"
    compileSdk = 35  // Use either 34 or 35, but be consistent

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_21
        targetCompatibility = JavaVersion.VERSION_21
    }

    kotlinOptions {
        jvmTarget = "21" // Match Java version here
    }

    defaultConfig {
        applicationId = "com.example.wayt"
        minSdk = 24
        targetSdk = 35
        versionCode = 1
        versionName = "1.0.0"

        // Updated manifest placeholders syntax
        manifestPlaceholders["GOOGLE_API_KEY"] = project.properties["GOOGLE_API_KEY"] ?: ""
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    // Remove duplicate compileSdk and compileOptions
    // Keep only one compileOptions block
}

flutter {
    source = "../.."
}

// Remove the ndkVersion line unless specifically required