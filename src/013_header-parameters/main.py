from typing import Annotated

from fastapi import FastAPI, Header

app = FastAPI()


@app.get("/items/")
async def read_items(user_agent: Annotated[str | None, Header()] = None):
    return {"User-Agent": user_agent}


@app.get("/strange-items/")
async def read_strange_items(
    strange_header: Annotated[str | None, Header(convert_underscores=False)] = None
):
    return {"strange_header": strange_header}


@app.get("/duplicate-items/")
async def read_duplicate_items(x_token: Annotated[list[str] | None, Header()] = None):
    return {"X-Token values": x_token}
