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

import { useState } from "react";
import { Button, Container, Form, Row, Stack } from "react-bootstrap";
import { NavLink, useNavigate } from "react-router-dom";

function NewBook() {
  // Instantiate the variables used for saving the state of the application
  const [title, setTitle] = useState("");
  const [author, setAuthor] = useState("");

  // Instantiate the navigate object which can be used for changing page
  const navigate = useNavigate();

  // Function that submits the data of the form to the API
  const onSubmit = (e) => {
    // Prevent that the default action is triggered (in this case the form submit)
    e.preventDefault();
    // Make a POST request to the API with the data of the new book as a JSON string
    fetch("http://localhost:8080/books/", {
      method: "POST",
      body: JSON.stringify({ title, author }),
      headers: { "Content-Type": "application/json" },
    })
      // On request successful reset the form and show the updated list of books
      .then(() => {
        // Navigate to the book list (homepage) using ReactRouter
        navigate("/");
      })
  };

  return (
    <>
      {/* Bootstrap container */}
      <Container>
        <Row>
          {/* Bootstrap Stack with margin-top: 3 and margin-bottom: 3 */}
          <Stack direction="horizontal" className="mt-3 mb-3">
            <h2>Add a new book</h2>
            {/* Button used to navigate to the main page */}
            <Button className="ms-auto" as={NavLink} to="/">Show all books</Button>
          </Stack>
          {/* Bootstrap Form with custom onSubmit function call */}
          <Form onSubmit={onSubmit}>
            {/* Bootstrap From Group used to ask the user the name of the book */}
            <Form.Group className="mb-3">
              {/* The title of the Form Label */}
              <Form.Label>Book</Form.Label>
              {/* The text field used to input the title of the book. 
                  The title of the book is a required field.
                  When the value is changed, the value is updated on the `title` variable */}
              <Form.Control
                type="text"
                required
                placeholder="Name of the book"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
              />
            </Form.Group>

            <Form.Group className="mb-3">
              <Form.Label>Author</Form.Label>
              <Form.Control
                type="text"
                required
                placeholder="Name of the author"
                value={author}
                onChange={(e) => setAuthor(e.target.value)}
              />
            </Form.Group>

            {/* Bootstrap Button that is used to submit the form */}
            <Button variant="primary" type="submit">
              Add
            </Button>
          </Form>
        </Row>
      </Container>
    </>
  );
}

// Expose the `NewBook` component to other modules
export default NewBook;
