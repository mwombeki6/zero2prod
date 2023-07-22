use zero2prod::run;

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    run()?.await
}
