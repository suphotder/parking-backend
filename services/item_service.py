from models.item_model import ItemModel


def get_all_items():
    new_item = ItemModel("1", "Note")
    return new_item.to_dict()