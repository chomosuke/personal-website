import Link from "next/link";

export default function Home() {
  return (
    <div
      style={{
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        width: "100vw",
        height: "100vh",
      }}
    >
      <div style={{ marginBottom: "20vh", width: "60vw" }}>
        <h1>Hello, you seems to have stumbled upon my personal website.</h1>
        <h2>
          I am still working on this at the moment, it&apos;ll get better soon.
        </h2>
        <p>
          This website <del>is</del> will be designed by my good friend Yu Jian
          (insert link and last name here).
        </p>
        <p>
          You can:
          <br />
          <Link href="/projects">
            <button>See a list of my projects.</button>
          </Link>
          <br />
          <Link href="/skills">
            <button>
              See a list of my skills with projects to back them up.
            </button>
          </Link>
        </p>
      </div>
    </div>
  );
}
