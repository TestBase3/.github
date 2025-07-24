# 🚀 TestBase3 - ChicBase Project

Build Flutter apps faster by sharing code across multiple applications.

## 🎯 Quick Setup

Get the clone tools and run the script for your workflow:

```
git clone git@github.com:Chic-Base/clone-tools.git
cd clone-tools
chmod +x *.sh

# Choose your workflow:
./clone_app.sh TestBase3        # Full app development
./clone_skeleton.sh TestBase3   # UI customization only  
./clone_superbase.sh TestBase3  # Shared components development
```

## 📦 What Gets Cloned

**🎨 Skeleton Development** (UI customization)
- **skeleton/** - Your app's UI and screens
- **metadata/** - Your app's assets and config  
- **sharedkernel/** - Shared utilities (read-only)

**🏗️ Superbase Development** (Shared components)
- **superbase/** - Reusable UI components
- **metadata/** - Test configurations
- **sharedkernel/** - Core utilities (read-only)

**🚀 Full App Development** (Everything)
- All 6 modules for complete app building

## ⚠️ Important

- Keep exact folder names (skeleton, metadata, etc.)
- Clone all repos in the same parent directory
- For SSH issues: [GitHub SSH Setup](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)

---

*ChicBase: Build once, use everywhere* ✨
