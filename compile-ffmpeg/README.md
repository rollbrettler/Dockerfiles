### Build image
```
docker build -t="build-ffmpeg" .
```

### Run Image
```
docker run -i -t --rm -v $(pwd)/build:/build build-ffmpeg
```
