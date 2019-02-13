package main

import (
    "os"
    "fmt"
    "log"
    "bufio"
    "errors"
    "strings"
    "net/http"
    "crypto/md5"
    "encoding/json"
    "github.com/hashicorp/golang-lru"
)

func mapUrl(api string, vhost string) (string, error) {
    sv := strings.Split(vhost, ".")
    if len(sv) < 3 {
        return "", errors.New("Wrong vhost format")
    }

    buildid := sv[1]

    url := fmt.Sprintf("%s/api/build/%s", api, buildid)
    res, err := http.Get(url)
    if err != nil {
        return "", err
    }
    defer res.Body.Close()

    var result map[string]interface{}
    err = json.NewDecoder(res.Body).Decode(&result)
    if err != nil {
        return "", err
    }

    log_url, ok := result["log_url"].(string)
    if !ok {
        return "", errors.New("Log URL not a string")
    }

    return log_url, nil
}

func main() {
    info, err := os.Stdin.Stat()
    if err != nil {
        panic(err)
    }

    if (info.Mode() & os.ModeCharDevice) != 0 || info.Size() <= 0 {
        os.Exit(1)
    }

    cache, _ := lru.New(1024)
    scanner := bufio.NewScanner(os.Stdin)
    for scanner.Scan() {
        line := scanner.Text()

        sv := strings.Split(line, " ")
        if len(sv) != 2 {
            fmt.Println("NULL")
        }
        api, vhost := sv[0], sv[1]

        key := md5.Sum([]byte(fmt.Sprintf("%s %s", api, vhost)))
        value, ok := cache.Get(key)

        if !ok {
            value, err := mapUrl(api, vhost)
            if err == nil {
                cache.Add(key, value)
            } else {
                log.Print(err)
                value = "NULL"
            }
            fmt.Println(value)
        } else {
            fmt.Println(value)
        }
	}
}
