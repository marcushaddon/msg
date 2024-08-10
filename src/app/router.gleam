import gleam/list
import gleam/string
import wisp.{type Request, type Response, path_segments}

pub fn handle_request(req: Request) -> Response {
  case path_segments(req) {
    [] -> wisp.ok() |> wisp.string_body("/root")
    ["user"] -> create_user(req)
    ["token"] -> create_token(req)
    ["subject"] -> create_subject(req)
    ["subject", subject_id] -> handle_msgs(req, subject_id)
    ["subject", subject_id, "permissions"] ->
      manage_permissions(req, subject_id)
    other ->
      wisp.not_found()
      |> wisp.string_body(
        other |> list.append(["not found"]) |> string.join("/"),
      )
  }
}

fn create_user(req: Request) -> Response {
  wisp.ok() |> wisp.string_body("create user")
}

fn create_token(req: Request) -> Response {
  wisp.ok() |> wisp.string_body("create token")
}

fn create_subject(req: Request) -> Response {
  wisp.ok() |> wisp.string_body("create subject")
}

fn handle_msgs(req: Request, subject_id: String) -> Response {
  ["create or list messages for", subject_id]
  |> string.concat()
  |> wisp.string_body(wisp.ok(), _)
}

fn manage_permissions(req: Request, subject_id) -> Response {
  ["manage permissions for", subject_id]
  |> string.concat()
  |> wisp.string_body(wisp.ok(), _)
}
