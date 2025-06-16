from huggingface_hub import InferenceClient

HF_TOKEN = "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"

def ask_ai(prompt: str):
    client = InferenceClient(
        provider="hf-inference",
        token=HF_TOKEN
    )

    response = client.chat_completion(
        model="microsoft/phi-4",
        messages=[{"role": "user", "content": prompt}]
    )
    return response.choices[0].message.content.strip()

if __name__ == "__main__":
    print(ask_ai("How are you?"))

