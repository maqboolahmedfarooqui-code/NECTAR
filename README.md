# 🛒 Grocery Shopping App - Flutter

A modern grocery shopping app built using **Flutter**, **Firebase Authentication**, and **SharedPreferences**.  
This app allows users to browse groceries, search products, manage a cart, mark favourites ❤️, and manage their account 👤.

---

## 📋 Table of Contents
1. [Features](#features)
2. [Screens](#screens)
3. [Project Structure](#project-structure)
4. [Dependencies](#dependencies)
5. [Installation](#installation)
6. [Usage](#usage)
7. [Data Storage](#data-storage)
8. [Notes](#notes)
9. [Author](#author)
10. [License](#license)

---

## ✨ Features

### 🏪 1. Shop Screen
- Displays products in a **grid view** with images, names, descriptions, prices, and quantity.
- Search functionality with **real-time filtering** 🔍.
- Carousel slider for promotional images 🖼️.
- Tap on a product to open the **Detail Page** with **Hero animation** ✨.

**Key Widgets & Functionality:**
- `GridView.builder` for product display
- `TextFormField` for searching products
- `CarouselSlider` for image sliders
- `Hero` widget for smooth image transition
- `SharedPreferences` to save **cart items locally** 💾

---

### 📦 2. Product Detail Screen
- Displays detailed information about a product:
  - Product image 🖼️
  - Name & description 📝
  - Price 💲
  - Detailed description 📖
- Add to **Cart 🛒** or **Favourites ❤️**.
- **Hero animation** for product image.
- **Favourite toggle** adds/removes product from favourites with visual feedback.

---

### 🛍️ 3. Cart Screen
- Shows all products added to the cart.
- **Quantity selector** (+/-) updates total price dynamically.
- Delete items from cart ❌.
- Checkout button opens **bottom sheet**:
  - Payment method (Card 💳 / Cash 💵)
  - Enter promo code 🎟️
- Shows **total price per item** based on quantity.

**Key Features:**
- Dynamic price calculation: `price x quantity`
- SharedPreferences ensures cart persists across app sessions
- BottomSheet with `DropdownButton` for payment method selection

---

### ❤️ 4. Favourites Screen
- Displays all products marked as favourite.
- Tap on a product opens **Detail Page**.
- Shows image, name, description, and price.

**Key Features:**
- Data stored using `SharedPreferences`
- Can remove from favourites via Detail screen toggle
- Handles empty state gracefully (`Favourite is Empty`)

---

### 👤 5. Account Screen
- Shows logged-in user **name** and **email** from Firebase.
- Features multiple list options:
  - Orders 🛒
  - My Details 📝
  - Delivery Address 📍
  - Payment Methods 💳
  - Promo Code 🎟️
  - Notification 🔔
  - Help ❓
  - About ℹ️
- **Logout** functionality with Firebase Authentication.

**Key Features:**
- Fetches data from Firestore (`getUserData`)
- `CustomListTile` widget for consistent design
- Logout clears session and navigates to **Login** screen 🔑

---

### 🧭 6. Bottom Navigation
- Allows switching between **Shop 🏪**, **Cart 🛒**, **Favourites ❤️**, and **Account 👤** screens.
- Current index maintained using `selectindex`.

**Key Features:**
- `BottomNavigationBar` with icons and labels
- Maintains state between tabs

---

## 📱 Screens

| Screen        | Description |
|---------------|-------------|
| 🏪 Shop       | Browse products, search, add to cart/favourites |
| 📦 Detail     | Product details with add to cart/favourite option |
| 🛍️ Cart      | View cart items, update quantity, checkout |
| ❤️ Favourites | View favourite items, tap to open detail |
| 👤 Account    | View account info, manage settings, logout |

---

## 📂 Project Structure

lib/
├─ component/
│ └─ CustomListTile.dart # Reusable widget for Account screen
├─ screeen/
│ ├─ shop.dart # Shop screen with product grid & search
│ ├─ detail.dart # Product detail screen
│ ├─ cart.dart # Cart screen
│ ├─ Favourite.dart # Favourites screen
│ ├─ account.dart # Account screen (Firebase user info)
│ └─ login.dart # Firebase login screen
└─ main.dart # App entry point
