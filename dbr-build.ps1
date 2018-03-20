# Select the platform.
Write-Host "Please select the number for your operating system." -Fore Yellow 
$os = Read-Host "1. Windows 2. Linux 3. macOS"

# Get the source code.
Write-Host "Downloading the source code..." -Fore Yellow 
$sourceURL = "https://github.com/dynamsoft-dbr/cmake.git"
git clone $sourceURL

if ($os -eq "1") {
    Write-Output "Configuring Windows..."

    # Set the library path.
    $libPath = Read-Host "Please add the .lib file path"
    $dllPath = Read-Host "Please add the .dll file path"

    # Copy library files to the destination folder.
    Copy-Item $libPath .\cmake\platforms\win\
    Copy-Item $dllPath .\cmake\platforms\win\

    # Build the project.
    Write-Host "Building the project..." -Fore Yellow 

    if ($libPath.Contains("x86.lib")) {
        New-Item -Path ".\cmake\build" -ItemType "directory"
        Set-Location -Path ".\cmake\build"
        cmake ..
        cmake --build .
    }
    else {
        New-Item -Path ".\cmake\build64" -ItemType "directory"
        Set-Location -Path ".\cmake\build64"
        cmake -G"Visual Studio 14 2015 Win64" ..
        cmake --build .
    }

    # Run the project.
    Write-Host "Testing the application..." -Fore Yellow 
    .\Debug\BarcodeReader.exe
}
elseif ($os -eq "2") {
    Write-Output "Configuring Linux..."

    # Set the library path.
    $soPath = Read-Host "Please add the .so file path"

    # Copy library files to the destination folder.
    Copy-Item $soPath ./cmake/platforms/linux

    # Build the project.
    New-Item -Path "./cmake/build" -ItemType "directory"
    Set-Location -Path "./cmake/build"
    cmake ..
    cmake --build .

    # Run the project.
    Write-Host "Testing the application..." -Fore Yellow 
    ./BarcodeReader
}
else {
    Write-Output "Configuring macOS..."

    # Set the library path.
    $dylibPath = Read-Host "Please add the .dylib file path"

    # Copy library files to the destination folder.
    Copy-Item $dylibPath ./cmake/platforms/macos

    # Build the project.
    New-Item -Path "./cmake/build" -ItemType "directory"
    Set-Location -Path "./cmake/build"
    cmake ..
    cmake --build .

    # Run the project.
    ./BarcodeReader
}



