function gopath {
    $env:GO15VENDOREXPERIMENT=1
    $env:GOPATH=$pwd
}

function update_gotools {
    echo "gocode"
    go get -u github.com/nsf/gocode
    echo "goimports"
    go get -u golang.org/x/tools/cmd/goimports
    echo "oracle"
    go get -u golang.org/x/tools/cmd/oracle
    echo "gb"
    go get -u github.com/constabulary/gb/...
    echo "protobuf"
    go get -u github.com/golang/protobuf/proto
    go get -u github.com/golang/protobuf/protoc-gen-go
    echo "godep"
    go get -u github.com/tools/godep
    echo "gogo protobuf"
    go get -u github.com/gogo/protobuf/proto
    go get -u github.com/gogo/protobuf/protoc-gen-gogo
    go get -u github.com/gogo/protobuf/gogoproto
}
