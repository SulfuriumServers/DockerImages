# Get the current working directory
$rootDirectory = Get-Location

# Recursively search for Dockerfiles in the current directory
$dockerfiles = Get-ChildItem -Path $rootDirectory -Recurse -Filter "Dockerfile"

# Loop through each Dockerfile and build and push the image
foreach ($dockerfile in $dockerfiles) {
    # Get the directory containing the Dockerfile
    $dockerfileDirectory = Split-Path -Path $dockerfile.FullName -Parent

    # Get the name of the image from the meta.txt file
    $metaFile = Join-Path -Path $dockerfileDirectory -ChildPath "meta.txt"
    $imageName = (Get-Content $metaFile).Trim()

    # Build the Docker image
    docker build -t $imageName $dockerfileDirectory

    # Push the Docker image to Docker Hub
    docker push $imageName
}