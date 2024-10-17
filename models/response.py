from dataclasses import dataclass
from typing import Any, Optional

@dataclass
class Response:
    status: int
    message: str
    data: Optional[Any] = None

    def to_dict(self):
        return {
            "status": self.status,
            "message": self.message,
            "data": self.data
        }