package main

import (
    "bufio"
	"log"
	"net"
	"os"
	"strconv"
	"container/list"
	"fmt"
	"flag"
)

func handler(conn net.Conn, text string) {
	defer conn.Close()

	w := bufio.NewWriter(conn)
	w.Write([]byte(text))
	w.Flush()
}

func main() {
	fileName := flag.String("f", "files.list", "the name")
	var port int
	flag.IntVar(&port, "p", 3334, "the year")
	flag.Parse()

	fmt.Println("file:", *fileName)
	fmt.Println("port:", port)

	// Init server socket
	listen, err := net.Listen("tcp4", ":"+strconv.Itoa(port))
	if err != nil {
		log.Fatalf("Socket listen port %d failed,%s", port, err)
		os.Exit(1)
	}
	defer listen.Close()
	log.Printf("Begin listen port: %d", port)

	// Read the file line by line and store it in the queue
	queue := list.New()
	file ,err := os.Open(*fileName)
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)
	for scanner.Scan() {
		queue.PushBack(scanner.Text()) // Enqueue
	}

	// return the first line of the file
	for {
		conn, err := listen.Accept()
		if err != nil {
			log.Fatalln(err)
			continue
		}
		text := "EOF"
		if queue.Len() > 0 {
			e := queue.Front() 	// First element
			queue.Remove(e) 	// Dequeue
			text = e.Value.(string)
		}
		log.Printf("Sending text: %s", text)
		go handler(conn,text)
	}
}
