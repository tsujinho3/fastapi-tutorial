from fastapi import FastAPI, Query

app = FastAPI()


@app.get("/items/")
async def read_items(
    q: str
    | None = Query(
        default=None,
        alias="item-query",
        title="Query string",
        description="Query string for the items to search in the database that have a good match",
        min_length=3,
        max_length=50,
        regex="^fixedquery$",
        deprecated=True,
    )
):
    results: dict[str, list[dict[str, str]] | str] = {
        "items": [{"item_id": "Foo"}, {"item_id": "Bar"}]
    }
    if q:
        results.update({"q": q})
    return results


@app.get("/default-items/")
async def read_default_items(q: str = Query(default="fixedquery", min_length=3)):
    results: dict[str, list[dict[str, str]] | str] = {
        "items": [{"item_id": "Foo"}, {"item_id": "Bar"}]
    }
    if q:
        results.update({"q": q})
    return results


@app.get("/required-items/")
async def read_required_items(q: str = Query(default=..., min_length=3)):
    # `default=...` can omit like `Query(min_length=3)`
    results: dict[str, list[dict[str, str]] | str] = {
        "items": [{"item_id": "Foo"}, {"item_id": "Bar"}]
    }
    if q:
        results.update({"q": q})
    return results


@app.get("/none-items/")
async def read_none_items(q: str | None = Query(default=..., min_length=3)):
    # You can use `pydantic.Required` insted of `...`
    results: dict[str, list[dict[str, str]] | str] = {
        "items": [{"item_id": "Foo"}, {"item_id": "Bar"}]
    }
    if q:
        results.update({"q": q})
    return results


@app.get("/multi-items/")
async def read_multi_items(q: list[str] = Query(default=["foo", "bar"])):
    query_items = {"q": q}
    return query_items


@app.get("/hidden-items/")
async def read_hidden_items(
    hidden_query: str | None = Query(default=None, include_in_schema=False)
):
    if hidden_query:
        return {"hidden_query": hidden_query}
    else:
        return {"hidden_query": "Not found"}
