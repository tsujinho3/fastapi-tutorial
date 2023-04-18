from typing import Annotated

from fastapi import FastAPI, Form

app = FastAPI()


@app.post("/login/")
async def login(
    username: Annotated[str, Form()], password: Annotated[str, Form()]
) -> dict[str, str]:
    return {"username": username}
