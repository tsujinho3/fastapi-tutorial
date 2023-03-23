from fastapi import Body, FastAPI, Path
from pydantic import BaseModel

app = FastAPI()


class Item(BaseModel):
    name: str
    description: str | None = None
    price: float
    tax: float | None = None


class User(BaseModel):
    username: str
    full_name: str | None = None


@app.put("/items/{item_id}")
async def update_item(
    *,
    item_id: int = Path(title="The ID of the item to get", ge=0, le=1000),
    q: str | None = None,
    item: Item | None = None,
):
    results: dict[str, int | str | Item] = {"item_id": item_id}
    if q:
        results.update({"q": q})
    if item:
        results.update({"item": item})
    return results


@app.put("/users-items/{item_id}")
async def update_body_item(
    item_id: int,
    item: Item,
    user: User,
    importance: int = Body(gt=0),
    q: str | None = None,
):
    results: dict[str, str | int | Item | User | None] = {
        "item_id": item_id,
        "item": item,
        "user": user,
        "importance": importance,
    }
    if q:
        results.update({"q": q})
    return results


@app.put("/embed-items/{item_id}")
async def update_embed_item(item_id: int, item: Item = Body(embed=True)):
    results = {"item_id": item_id, "item": item}
    return results
