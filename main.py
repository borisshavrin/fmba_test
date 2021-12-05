import os
from glob import glob


labels_dir = "/tmp/labels/"


def makedirs():
    """Исходные данные"""
    os.makedirs(labels_dir, exist_ok=True)

    labels = {
        "label1": ["1image.JPG", "2.jpeg", "2.json", "1image.json", "3.jpg"],
        "label2": ["1.jpg", "1.json", "2.json", "3.json"],
        "label3": ["15.png", "15.json", "16.json", "16.jpg", "1.PNG", "1.JSON"],
        "label4": ["1.png", "1.txt", "2.txt"],
    }

    for label in labels:
        label_path = os.path.join(labels_dir, label)
        os.makedirs(label_path, exist_ok=True)
        for item in labels[label]:
            open(os.path.join(label_path, item), 'a').close()

        # print(f"{label_path} {os.listdir(label_path)}")


def images_or_meta_filter(items) -> dict:
    """
    Фильтрация расширений файлов
    :param items: Список файлов со всеми его расширениями
    :return: Список файлов с разрешениями "png", "jpg", "jpeg", "json"
    """
    extensions = ["png", "jpg", "jpeg", "json"]
    images_or_meta = {}
    for item in items:
        name, extension = item.lower().split('.')
        if extension in extensions:
            try:
                item_ext = images_or_meta[name]
            except KeyError:
                images_or_meta[name] = [extension]
            else:
                item_ext.append(extension)
    return images_or_meta


def get_list_labels() -> list:
    """
    :return: Список изображений с метаданными для каждой папки из labels
    """
    list_labels = []
    dirlist = [dirname for dirname in os.listdir(labels_dir) if os.path.isdir(os.path.join(labels_dir, dirname))]
    for dirname in dirlist:
        label_path = os.path.join(labels_dir, dirname)
        items = os.listdir(label_path)
        images_or_meta = images_or_meta_filter(items)
        labels = {dirname: []}
        for filename, extensions in images_or_meta.items():
            items_path_list = []
            if len(extensions) > 1:
                items_path_list.extend(glob(label_path + "/" + f"{filename}.*"))
                items_path_list = [i.replace(os.sep, "/") for i in items_path_list]
                labels[dirname].append(items_path_list)

        if labels[dirname]:
            list_labels.append(labels)
    return list_labels


def write_list_labels(filename):
    data = get_list_labels()
    print(*data, file=filename, sep="\n")


if __name__ == "__main__":
    makedirs()
    with open(os.path.join(labels_dir, "test.txt"), 'w', encoding="utf-8") as file:
        write_list_labels(file)
