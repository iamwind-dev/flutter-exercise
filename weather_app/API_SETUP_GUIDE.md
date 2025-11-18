# API Configuration Guide

## Getting Your OpenWeatherMap API Key

Follow these steps to get your free API key:

### Step 1: Sign Up
1. Visit https://openweathermap.org/
2. Click "Sign Up" in the top right corner
3. Fill in your details:
   - Email address
   - Username
   - Password
4. Agree to terms and complete the registration

### Step 2: Verify Email
1. Check your email inbox
2. Click the verification link sent by OpenWeatherMap
3. Your account will be activated

### Step 3: Get API Key
1. Log in to your OpenWeatherMap account
2. Go to https://home.openweathermap.org/api_keys
3. You'll see a default API key already created
4. Or click "Generate" to create a new key
5. Give it a name (e.g., "Weather App Flutter")
6. Copy the API key (it looks like: `a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6`)

### Step 4: Configure the App
1. Open `lib/services/weather_service.dart`
2. Find this line:
   ```dart
   static const String _apiKey = 'YOUR_API_KEY_HERE';
   ```
3. Replace `YOUR_API_KEY_HERE` with your actual API key:
   ```dart
   static const String _apiKey = 'a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6';
   ```
4. Save the file

### Step 5: Wait for Activation
⚠️ **Important**: New API keys can take up to 2 hours to activate!
- Don't worry if you get "Invalid API key" errors initially
- Wait 10-15 minutes and try again
- Usually activates within 10 minutes, but can take up to 2 hours

## API Key Features (Free Tier)

✅ What you get for FREE:
- 60 calls per minute
- 1,000,000 calls per month
- Current weather data
- 5 day / 3 hour forecast data
- No credit card required

## Testing Your API Key

You can test your API key in a browser or terminal:

### Browser Test
Open this URL in your browser (replace `YOUR_API_KEY`):
```
https://api.openweathermap.org/data/2.5/weather?q=London&appid=YOUR_API_KEY&units=metric
```

If it works, you'll see JSON data like:
```json
{
  "coord": {"lon": -0.1257, "lat": 51.5085},
  "weather": [{"id": 800, "main": "Clear", "description": "clear sky"}],
  "main": {"temp": 15.5, "humidity": 72},
  "name": "London"
}
```

### PowerShell Test (Windows)
```powershell
Invoke-RestMethod -Uri "https://api.openweathermap.org/data/2.5/weather?q=London&appid=YOUR_API_KEY&units=metric"
```

### Error Messages

#### 401 Unauthorized
```json
{"cod":401, "message": "Invalid API key"}
```
**Solution**: 
- Check your API key is correct
- Wait for key activation (up to 2 hours)
- Ensure no extra spaces in the key

#### 429 Too Many Requests
```json
{"cod":429, "message": "Too many requests"}
```
**Solution**: 
- You've exceeded 60 calls/minute
- Wait 1 minute and try again

#### 404 Not Found
```json
{"cod":"404", "message":"city not found"}
```
**Solution**: 
- City name is incorrect
- Try different spelling or city

## Best Practices

### 1. Keep API Key Secret
❌ DON'T:
- Commit API keys to public GitHub repositories
- Share your API key publicly
- Post it in forums or chat

✅ DO:
- Use environment variables in production
- Add `.env` to `.gitignore`
- Rotate keys if exposed

### 2. Environment Variables (Optional)
For production apps, use environment variables:

Create `.env` file:
```
OPENWEATHER_API_KEY=your_key_here
```

Use with `flutter_dotenv` package:
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

static final String _apiKey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';
```

### 3. Rate Limiting
- Free tier: 60 calls/minute
- Add caching to reduce API calls
- Store last fetch time
- Only refresh when needed (e.g., every 10 minutes)

## API Endpoints Used

### Current Weather
```
GET https://api.openweathermap.org/data/2.5/weather
```

**Parameters**:
- `q` - City name (e.g., London)
- `lat` - Latitude (e.g., 51.5074)
- `lon` - Longitude (e.g., -0.1278)
- `appid` - Your API key
- `units` - metric (Celsius) or imperial (Fahrenheit)

**Example**:
```
https://api.openweathermap.org/data/2.5/weather?lat=51.5074&lon=-0.1278&appid=YOUR_KEY&units=metric
```

## Troubleshooting

### Problem: "Invalid API key" error
**Solutions**:
1. Wait 10-15 minutes for key activation
2. Check for typos in the API key
3. Ensure no spaces before/after the key
4. Verify you're logged into the correct account

### Problem: No data returned
**Solutions**:
1. Check internet connection
2. Verify API endpoint URL
3. Test API key in browser first
4. Check OpenWeatherMap service status

### Problem: City not found
**Solutions**:
1. Try different city name spelling
2. Include country code: "London,UK"
3. Use coordinates instead
4. Check city name exists in OpenWeatherMap database

## Additional Resources

- 📚 [OpenWeatherMap API Documentation](https://openweathermap.org/api)
- 🌡️ [Current Weather API](https://openweathermap.org/current)
- 🗺️ [Weather Condition Codes](https://openweathermap.org/weather-conditions)
- 💰 [Pricing Plans](https://openweathermap.org/price)
- 📞 [Support](https://openweathermap.org/faq)

## Quick Reference

### API Key Location in Code
```
lib/services/weather_service.dart
Line 9: static const String _apiKey = 'YOUR_API_KEY_HERE';
```

### Test Cities
Good cities to test with:
- London, UK
- New York, US
- Tokyo, JP
- Paris, FR
- Sydney, AU

---

**Need Help?** 
If you're still having issues, check the OpenWeatherMap FAQ or their support page.
