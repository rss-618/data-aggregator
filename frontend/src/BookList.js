/// Copyright (c) 2022 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import { useEffect, useState } from "react";
import { Button, Container, Row, Stack, Table } from "react-bootstrap";
import { NavLink } from "react-router-dom";

function BookList() {
  // Define all the variables needed for the book list
  const [booksData, setBooksData] = useState(null);

  // Function that will load the books from the backend
  function loadBooks() {
    // Clear the booksData variable
    setBooksData(null);

    // Fetch the books from the backend
    fetch("http://localhost:8080/books/")
      // Convert the response to a JSON object
      .then((response) => response.json())
      // Save the JSON object in the booksData variable
      .then((json) => setBooksData(json));
  }

  // Call the loadBooks function using `useEffect` since loadBooks is going to modify the data on the page
  useEffect(() => {
    loadBooks();
  }, []);

  return (
    <>
      {/* Bootstrap container */}
      <Container>
        {/* Bootstrap row */}
        <Row className="">
          {/* Bootstrap Stack with margin-top: 3 and margin-bottom: 3 */}
          <Stack direction="horizontal" className="mt-3 mb-3">
            <h2>Book List</h2>
            {/* Button used to navigate to the "/newbook" page */}
            <Button className="ms-auto" as={NavLink} to="/newbook">Add new book</Button>
          </Stack>
          <Table bordered hover>
            {/* Table Header */}
            <thead>
              <tr>
                <th>Book Name</th>
                <th>Author</th>
              </tr>
            </thead>
            {/* Table Body */}
            <tbody>
              {/* If booksData is not null, render the data as a table row */}
              {booksData &&
                booksData.map(({ id, title, author }) => (
                  <>
                    {/* Set the key of the row for optimizing react performance */}
                    <tr key={id}>
                      {/* Print the title and the author of the book as a table cell */}
                      <td>{title}</td>
                      <td>{author}</td>
                    </tr>
                  </>
                ))}
            </tbody>
          </Table>
        </Row>
      </Container>
    </>
  );
}

// Expose the `BookList` component to other modules
export default BookList;
